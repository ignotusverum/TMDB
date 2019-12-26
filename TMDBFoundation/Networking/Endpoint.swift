//
//  Endpoint.swift
//  TheMovies
//
//  Created by Mikhail Pchelnikov on 13/11/2018.
//  Copyright © 2018 Michael Pchelnikov. All rights reserved.
//

import Foundation

public protocol Endpoint {
    var path: String { get }
}

public enum ShowType: String {
    case movie
    case tvSeries = "tv"
}

public enum TheMovieDBEndpoint {
    case search(show: ShowType, query: String, page: Int)
    case discoverPopular(show: ShowType, page: Int)
    case getDetails(show: ShowType, id: Int64)
}

extension TheMovieDBEndpoint: Endpoint {
    public var path: String {
        switch self {
        case let .search(show, query, page):
            return "\(Config.URL.base)/search/\(show.rawValue)?api_key=\(Config.apiKey)&query=\(query)&page=\(page)"
        case let .discoverPopular(show, page):
            return "\(Config.URL.base)/discover/\(show.rawValue)?api_key=\(Config.apiKey)&page=\(page)&sort_by=popularity.desc"
        case let .getDetails(show, id):
            return "\(Config.URL.base)/\(show)/\(id)?api_key=\(Config.apiKey)&language=en-US"
        }
    }
}
