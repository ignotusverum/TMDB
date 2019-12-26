//
//  File.swift
//  TMDB
//
//  Created by Giuseppe Lanza on 14/11/2019.
//  Copyright © 2019 MERLin Tech. All rights reserved.
//

import TMDBFoundation

protocol TMDBViewControllerBuilding: ViewControllerBuilding {
    func searchViewController() -> UISearchController
}


class TMDBNavigationController: UINavigationController {
    fileprivate(set) weak var viewControllersFactory: ViewControllersFactory? {
        didSet {
            guard let root = viewControllers.first else { return }
            setupSearch(for: root)
        }
    }
    
    var localizedTitle: (() -> String)?
    
    func setupSearch(for viewController: UIViewController) {
        guard let searching = viewController as? TMDBSearching,
            let factory = viewControllersFactory as? TMDBViewControllerBuilding else { return }
        
        let handler = SearchHandler(with: factory.searchViewController())
        handler.setupSearchController(for: searching)
        
        switch searching.searchStyle {
        case .none: break
        case .fromButton:
            let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: handler, action: #selector(handler.beginSearchAction))
            viewController.navigationItem.rightBarButtonItem = searchButton
        case .fromSearchBar:
            viewController.navigationItem.titleView = handler.searchController.searchBar
        case .asTableViewHeader:
            viewController.navigationItem.searchController = handler.searchController
        }
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewControllers
            .compactMap { $0 as? TMDBSearching }
            .forEach {
                $0.definesPresentationContext = false
            }
        setupSearch(for: viewController)
        super.pushViewController(viewController, animated: animated)
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        let result = super.popViewController(animated: true)
        (result as? Searching)?.searchHandler.searchController.isActive = false
        (viewControllers.last as? TMDBSearching)?.definesPresentationContext = true
        return result
    }
    
    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        let result = super.popToRootViewController(animated: animated)
        result?.compactMap { $0 as? Searching }
            .forEach {
                $0.searchHandler.searchController.isActive = false
            }
        (viewControllers.last as? TMDBSearching)?.definesPresentationContext = true
        return result
    }
}

class AppRouter: Router {
    private(set) weak var viewControllersFactory: ViewControllersFactory?
    
    let navBarController: UINavigationController
    var topViewController: UIViewController { return navBarController }
    
    var disposeBag: DisposeBag = DisposeBag()
    
    init(withFactory viewControllersFactory: ViewControllersFactory) {
        self.viewControllersFactory = viewControllersFactory
        navBarController = UINavigationController(
            rootViewController: viewControllersFactory
                .viewController(for: PresentableRoutingStep(
                    withStep: .discover(),
                    presentationMode: .none
                ))
        )
    }

    func rootViewController(forLaunchOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> UIViewController? {
        return navBarController
    }
    
    func handleShortcutItem(_ item: UIApplicationShortcutItem) { }
    
    func showLoadingView() { }
    func hideLoadingView() { }
    
    fileprivate func navigationController(rootViewController: UIViewController, tabBarItem: UITabBarItem? = nil) -> UINavigationController {
        // rootViewController.navigationItem.titleView = UIImageView(image: Asset.hudsonsBayLogo.image)
        
        let navigationController = TMDBNavigationController(rootViewController: rootViewController)
        navigationController.viewControllersFactory = viewControllersFactory
        
        navigationController.tabBarItem = tabBarItem
        return navigationController
    }

}

