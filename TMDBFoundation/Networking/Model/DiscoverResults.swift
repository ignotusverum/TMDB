//
//  MoviesResults.swift
//  TheMovies
//
//  Created by Mikhail Pchelnikov on 10/06/2018.
//  Copyright © 2018 Michael Pchelnikov. All rights reserved.
//

import Foundation

/// Data structure for movies search results.
public struct DiscoverResults<T: Decodable>: Decodable {
    public let results: [T]
}
