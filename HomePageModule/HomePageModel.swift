//
//  HomePageModel.swift
//  HomePageModule
//
//  Created by Giuseppe Lanza on 04/12/2019.
//  Copyright © 2019 MERLin Tech. All rights reserved.
//

protocol HomePageModel {
    func getMovies(page: Int) -> Single<[Movie]>
}

class HomeModel: HomePageModel {
    func getMovies(page: Int) -> Single<[Movie]> {
        TheMovieDBApi.shared.discoverPopularMovies(page: page)
    }
}
