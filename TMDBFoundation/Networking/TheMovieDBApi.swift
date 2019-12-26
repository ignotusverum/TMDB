//
//  TheMovieDBApi.swift
//  TheMovies
//
//  Created by Mikhail Pchelnikov on 13/11/2018.
//  Copyright © 2018 Michael Pchelnikov. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa

final public class TheMovieDBApi {
    public static let shared = TheMovieDBApi(manager: .shared)
    let manager: APIManager
    
    public init(manager: APIManager) {
        self.manager = manager
        Logging.URLRequests = { _ in false }
    }
    
    public func searchMovies(query: String, page: Int) -> Single<[Movie]> {
        return manager
            .request(for: TheMovieDBEndpoint.search(show: .movie, query: query, page: page))
            .map(parseThrowing)
    }

    public func discoverPopularMovies(page: Int) -> Single<[Movie]> {
        return manager.request(for: TheMovieDBEndpoint.discoverPopular(show: .movie, page: page))
            .map { Response.parse(type: DiscoverResults<Movie>.self, data: $0) }
            .flatMap {
                switch $0 {
                case let .success(result): return .just(result.results)
                case let .failed(error): return .error(error)
                }
        }
    }
    
    public func discoverPopularTvSeries(page: Int) -> Single<[TVSeries]> {
        return manager.request(for: TheMovieDBEndpoint.discoverPopular(show: .tvSeries, page: page))
            .map { Response.parse(type: DiscoverResults<TVSeries>.self, data: $0) }
            .flatMap {
                switch $0 {
                case let .success(result): return .just(result.results)
                case let .failed(error): return .error(error)
                }
        }
    }
    
    public func getMovieDetails(movieId: Int64) -> Single<Movie> {
        return manager.request(for: TheMovieDBEndpoint.getDetails(show: .movie, id: movieId))
            .map { Response.parse(type: Movie.self, data: $0) }
            .flatMap {
                switch $0 {
                case let .success(result): return .just(result)
                case let .failed(error): return .error(error)
                }
        }
    }
}
