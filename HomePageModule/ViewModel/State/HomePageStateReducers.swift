//
//  HomePageStateReducers.swift
//  HomePageModule
//
//  Created by Vlad Zagorodnyuk on 12/26/19.
//  Copyright © 2019 MERLin Tech. All rights reserved.
//

class HomePageStateReducers {
    static func reduce(_ state: HomePageState,
                       action: HomePageUIAction)-> HomePageState {
        
        switch (state, action) {
        case (.emptyView, .reload),
             (.emptyView, .nextPage): return .loading(page: 0,
                                                      whileInState: .emptyView)
        case (let .shows(movies, page), .reload):
            return .loading(page: 0,
                            whileInState: .shows(movies,
                                                 page: page))
        case (let .shows(movies, page), .nextPage):
            return .loading(page: page+1,
                            whileInState: .shows(movies,
                                                 page: page))
        case (let .error(_, previous), _):
            return reduce(previous.toViewState(), action: action)
            /// Impossible UI states
        case (.loading, .reload),
             (.loading, .nextPage),
             (.loading, .selectMovie(_)),
             (.emptyView, .selectMovie(_)): return state
            /// Does not change state, handled in side effects
        case (.shows, .selectMovie(_)):
            return state
        }
    }
    
    static func reduce(_ state: HomePageState,
                       action: HomePageModelAction)-> HomePageState {
        switch (state, action) {
        case (.emptyView, let .loaded(movies, page)),
             (.error(_, .emptyView), let .loaded(movies, page)),
             (.loading(_, .emptyView), let .loaded(movies, page)): return .shows(movies,
                                                                  page: page)
        case (let .error(_, previous), let .loaded(newMovies, page)),
             (let .loading(_, previous), let .loaded(newMovies, page)):
            guard case let .shows(movies, _) = previous else { return state }
            return showsState(oldList: movies,
                              newList: newMovies,
                              page: page)
        case (let .shows(movies, _), let .loaded(newMovies, newPage)): return showsState(oldList: movies,
                                                                                         newList: newMovies,
                                                                                         page: newPage)
        case (let .loading(_, previous), let .error(error)),
             (let .error(_, previous), let .error(error)): return .error(error,
                                                                         whileInState: previous)
        case (let .shows(movies, page), let .error(error)): return .error(error,
                                                                          whileInState: .shows(movies,
                                                                                               page: page))
        case (.emptyView, let .error(error)): return .error(error,
                                                            whileInState: .emptyView)
        }
    }
}

func showsState(oldList: [MovieListEntryModel],
                newList: [MovieListEntryModel],
                page: Int) -> HomePageState {
    var finalMovies = oldList + newList
    if page == 1 {
        finalMovies = newList
    }
    
    return .shows(finalMovies,
                  page: page)
}
