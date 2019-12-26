//
//  HomePageAction.swift
//  HomePageModule
//
//  Created by Vlad Zagorodnyuk on 12/26/19.
//  Copyright © 2019 MERLin Tech. All rights reserved.
//

enum HomePageUIAction: EventProtocol {
    case reload
    case nextPage
    case selectMovie(Movie)
}

enum HomePageModelAction: EventProtocol {
    case error(Error)
    case loaded([Movie], page: Int)
}

enum HomePageAction: EventProtocol {
    case ui(HomePageUIAction)
    case model(HomePageModelAction)
}
