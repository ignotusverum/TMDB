//
//  HomePageModel.swift
//  HomePageModule
//
//  Created by Giuseppe Lanza on 04/12/2019.
//  Copyright © 2019 MERLin Tech. All rights reserved.
//

protocol HomePageModel {
    func getData(page: Int) -> Single<[MovieListEntryModel]>
}

class HomeMoviesModel: HomePageModel {
    func getData(page: Int) -> Single<[MovieListEntryModel]> {
        TheMovieDBApi.shared
            .discoverPopularMovies(page: page)
            .map { $0 as [MovieListEntryModel] }
    }
}

class HomeSeriesModel: HomePageModel {
    func getData(page: Int) -> Single<[MovieListEntryModel]> {
        TheMovieDBApi.shared
            .discoverPopularTvSeries(page: page)
            .map { $0 as [MovieListEntryModel] }
    }
}
