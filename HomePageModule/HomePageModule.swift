//
//  HomePageModule.swift
//  HomePageModule
//
//  Created by Giuseppe Lanza on 25/11/2019.
//  Copyright © 2019 MERLin Tech. All rights reserved.
//

public enum HomePagePresentationType {
    case movies
    case tvSeries
}

public class HomePageContext: ModuleContextProtocol {
    public typealias ModuleType = HomePageModule
    
    public var routingContext: String
    fileprivate var presentationType: HomePagePresentationType
    public init(routingContext: String,
                presentationType: HomePagePresentationType) {
        self.routingContext = routingContext
        self.presentationType = presentationType
    }
    
    public func make() -> (AnyModule, UIViewController) {
        let module = ModuleType(usingContext: self)
        return (module, module.prepareRootViewController())
    }
}

public enum HomePageEvents: EventProtocol {
    case movieSelected(Movie)
}

public class HomePageModule: ModuleProtocol, EventsProducer {
    public var events: Observable<HomePageEvents> { return _events.asObservable() }
    private var _events = PublishSubject<HomePageEvents>()
    
    public var context: HomePageContext
    public func unmanagedRootViewController() -> UIViewController {
        let model: HomePageModel = context.presentationType == .movies ? HomeMoviesModel() : HomeSeriesModel()
        let viewModel = HomePageViewModel(model: model,
                                          events: _events)
        let viewController = HomeViewController(with: viewModel)
        
        return viewController
    }
    
    public required init(usingContext buildContext: HomePageContext) {
        self.context = buildContext
    }
}
