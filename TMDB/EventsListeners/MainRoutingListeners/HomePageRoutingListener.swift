//
//  HomePageRoutingListener.swift
//  TMDB
//
//  Created by Vlad Zagorodnyuk on 12/26/19.
//  Copyright © 2019 MERLin Tech. All rights reserved.
//

import MERLin

class HomePageRoutingListener: ModuleEventsListener {
    var router: Router
    init(_ router: Router) {
        self.router = router
    }
    
    func listenEvents(from module: AnyEventsProducerModule,
                      events: Observable<HomeEvents>) -> Bool {
        events.capture(case: HomeEvents.movieSelected)
            .toRoutableObservable()
            .subscribe(onNext: { movie in
                // TODO: Route to Movie detail module
                print("show movie - \(movie.title)")
            })
            .disposed(by: module.disposeBag)

        return true
    }
}
