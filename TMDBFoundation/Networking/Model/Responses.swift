//
//  MoviesResponse.swift
//  TheMovies
//
//  Created by Mikhail Pchelnikov on 10/06/2018.
//  Copyright © 2018 Michael Pchelnikov. All rights reserved.
//

import Foundation

/// Movies response handler (JSON parsing).
public enum Response<T: Decodable> {
    case success(result: T)
    case failed(error: ApiErrorType)

    /// Parses data from API response.
    ///
    /// - Parameter jsonData: JSON as Data
    /// - Returns: MoviesResponse
    static func parse(type: T.Type, data: Data) -> Response<T> {
        guard let result = try? JSONDecoder.theMovieDB.decode(T.self, from: data) else {
            return .failed(error: .parseError)
        }
        return .success(result: result)
    }
}

func parseThrowing<T: Decodable>(data: Data) throws -> T {
    guard let result = try? JSONDecoder.theMovieDB.decode(T.self, from: data) else {
        throw ApiErrorType.parseError
    }
    return result
}
