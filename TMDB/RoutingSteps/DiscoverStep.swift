//
//  DiscoverStep.swift
//  TMDB
//
//  Created by Giuseppe Lanza on 04/12/2019.
//  Copyright © 2019 MERLin Tech. All rights reserved.
//

import MERLin
import HomePageModule

typealias HomeEvents = HomePageEvents

extension ModuleRoutingStep {
    static func discover(routingContext: String = "main") -> ModuleRoutingStep {
        let context = ModuleContext(
            routingContext: routingContext,
            building: HomePageModule.self
        )
        return ModuleRoutingStep(withMaker: context)
    }
}
