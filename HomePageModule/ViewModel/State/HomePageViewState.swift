//
//  HomePageViewState.swift
//  HomePageModule
//
//  Created by Vlad Zagorodnyuk on 12/26/19.
//  Copyright © 2019 MERLin Tech. All rights reserved.
//

enum HomeOverlayCases: CaseAccessible {
    case emptyView
    case shows([MovieListEntryModel], page:  Int)
    
    func toViewState() -> HomePageState {
        switch self {
        case .emptyView: return .emptyView
        case let .shows(movies, page): return .shows(movies, page: page)
        }
    }
}

enum HomePageState: CaseAccessible {
    case emptyView
    case shows([MovieListEntryModel], page:  Int)
    case error(Error, whileInState: HomeOverlayCases)
    case loading(page: Int, whileInState: HomeOverlayCases)
    
    static func reduce(_ state: HomePageState,
                       action: HomePageUIAction)-> HomePageState {
        HomePageStateReducers.reduce(state,
                                     action: action)
    }
    
    static func reduce(_ state: HomePageState,
                       action: HomePageModelAction)-> HomePageState {
        HomePageStateReducers.reduce(state,
                                     action: action)
    }
}
