//
//  HomePageModule.swift
//  HomePageModule
//
//  Created by Giuseppe Lanza on 25/11/2019.
//  Copyright © 2019 MERLin Tech. All rights reserved.
//

enum HomePageEvents: EventProtocol {
    case movieSelected(Movie)
}

public class HomePageModule: ModuleProtocol {
    var events: Observable<HomePageEvents> { return _events.asObservable() }
    private var _events = PublishSubject<HomePageEvents>()
    
    public var context: ModuleContext
    public func unmanagedRootViewController() -> UIViewController {
        let model = HomeModel()
        let viewModel = HomePageViewModel(model: model,
                                          events: _events)
        let viewController = HomeViewController(with: viewModel)
        return viewController
    }
    
    public required init(usingContext buildContext: ModuleContext) {
        self.context = buildContext
    }
}
