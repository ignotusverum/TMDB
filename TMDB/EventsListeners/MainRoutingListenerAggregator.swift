//
//  MainRoutingListenerAggregator.swift
//  TMDB
//
//  Created by Vlad Zagorodnyuk on 12/26/19.
//  Copyright © 2019 MERLin Tech. All rights reserved.
//

import MERLin

class MainRoutingListenerAggregator: ModuleEventsListenersAggregator {
    var handledRoutingContext: [String]? = ["main", "deeplink"]
    
    let moduleListeners: [AnyModuleEventsListener]
    
    init(withRouter router: Router) {
        moduleListeners = [
            HomePageRoutingListener(router)
        ]
    }
}
