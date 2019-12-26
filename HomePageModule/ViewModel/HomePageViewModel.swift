//
//  HomePageViewModel.swift
//  HomePageModule
//
//  Created by Vlad Zagorodnyuk on 12/26/19.
//  Copyright © 2019 MERLin Tech. All rights reserved.
//

protocol HomePageViewModelProtocol {
    func transform(input: Observable<HomePageUIAction>)-> Observable<HomePageState>
}

class HomePageViewModel: HomePageViewModelProtocol {
    let model: HomePageModel
    let events: PublishSubject<HomePageEvents>
    
    var currentPage: Int = 1
    
    init(model: HomePageModel,
         events: PublishSubject<HomePageEvents>) {
        self.model = model
        self.events = events
    }
    
    func transform(input: Observable<HomePageUIAction>)-> Observable<HomePageState> {
        let errors = PublishSubject<Error>()
        return Observable.feedbackLoop(initialState: .loading(page: currentPage,
                                                              whileInState: .emptyView),
                                scheduler: MainScheduler.asyncInstance,
                                reduce: { (state, action) -> HomePageState in
                                    switch action {
                                    case let .ui(action): return .reduce(state,
                                                                         action: action)
                                    case let .model(action): return .reduce(state,
                                                                            action: action)
                                    }
                                },
                                feedback: { _ in input.map(HomePageAction.ui) },
                                weakify(self,
                                        default: .empty()) { (me: HomePageViewModel, state) in
                                            Observable.merge(
                                                Observable.merge(
                                                    input.capture(case: HomePageUIAction.reload).map { _ in 1 },
                                                    input.capture(case: HomePageUIAction.nextPage).map { [weak me ] _-> Int in (me?.currentPage ?? 0) + 1 }
                                                    )
                                                    .compactFlatMapLatest { [weak me] page in
                                                        return me?.model.getMovies(page: page)
                                                            .asObservable()
                                                            .catchError(sendTo: errors)
                                                            .map { ($0, page) }
                                                    }
                                                .map(HomePageModelAction.loaded),
                                                errors.map(HomePageModelAction.error)
                                            ).map(HomePageAction.model)
        }).sendSideEffects({ state in
            input.capture(case: HomePageUIAction.selectMovie)
                .map(HomePageEvents.movieSelected)
        }, to: events.asObserver())
    }
}
