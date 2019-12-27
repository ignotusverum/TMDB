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
    static func movies(routingContext: String = "main") -> ModuleRoutingStep {
        let context = HomePageContext(
            routingContext: routingContext,
            presentationType: .movies
        )
        return ModuleRoutingStep(withMaker: context)
    }
    
    static func tvSeries(routingContext: String = "main") -> ModuleRoutingStep {
        let context = HomePageContext(
            routingContext: routingContext,
            presentationType: .tvSeries
        )
        return ModuleRoutingStep(withMaker: context)
    }
}
