//
//  File.swift
//  TMDBFoundation
//
//  Created by Giuseppe Lanza on 14/11/2019.
//  Copyright © 2019 MERLin Tech. All rights reserved.
//

import Foundation

public struct TVSeries:
    Decodable,
    Equatable,
    MovieListEntryModel {
    enum CodingKeys: String, CodingKey {
        case id, overview, popularity
        case title = "name"
        case posterPath = "poster_path"
        case averageVote = "vote_average"
        case voteCount = "vote_count"
    }
    
    public let id: Int64
    public let title: String
    public let overview: String
    public let posterPath: String?
    public let releaseDate: Date? = nil
    public let popularity: Double
    public let averageVote: Double
    public let voteCount: Int
    
    public static func == (lhs: TVSeries,
                    rhs: TVSeries) -> Bool {
        lhs.id == rhs.id
    }
}
