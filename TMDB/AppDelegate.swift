//
//  AppDelegate.swift
//  TMDB
//
//  Created by Giuseppe Lanza on 14/11/2019.
//  Copyright © 2019 MERLin Tech. All rights reserved.
//

import UIKit
import MERLin
import ThemeManager

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    let disposeBag = DisposeBag()
    
    var window: UIWindow?
    
    var moduleManager: BaseModuleManager!
    var router: AppRouter!
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()

        if #available(iOS 13.0, *) {
            window?.rx.sentMessage(#selector(UIWindow.traitCollectionDidChange(_:)))
                .map { _ in UITraitCollection.current.userInterfaceStyle }
                .startWith(UITraitCollection.current.userInterfaceStyle)
                .distinctUntilChanged()
                .subscribe(onNext: {
                    switch $0 {
                    case .light, .unspecified: ThemeContainer.defaultTheme = Theme()
                    case .dark: ThemeContainer.defaultTheme = DarkTheme()
                    @unknown default: ThemeContainer.defaultTheme = Theme()
                    }
                }).disposed(by: disposeBag)
        } else {
            ThemeContainer.defaultTheme = Theme()
        }
        
        moduleManager = BaseModuleManager()
        router = AppRouter(withFactory: moduleManager)
        
        let mainRoutingListener = MainRoutingListenerAggregator(withRouter: router)
        moduleManager.addEventsListeners([mainRoutingListener])
        
        window?.rootViewController = router.rootViewController(forLaunchOptions: launchOptions)
        window?.makeKeyAndVisible()
        
        return true
    }
}

