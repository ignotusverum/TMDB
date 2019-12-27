//
//  Movie.swift
//  TheMovies
//
//  Created by Mikhail Pchelnikov on 10/06/2018.
//  Copyright © 2018 Michael Pchelnikov. All rights reserved.
//

public struct Movie:
    Equatable,
    Decodable,
    MovieListEntryModel {
    enum CodingKeys: String, CodingKey {
        case id, title, overview, popularity
        case posterPath  = "poster_path"
        case releaseDate = "release_date"
        case averageVote = "vote_average"
        case voteCount = "vote_count"
    }

    public let id: Int64
    public let title: String
    public let overview: String
    public let posterPath: String?
    public let popularity: Double
    public let releaseDate: Date?
    public let averageVote: Double
    public let voteCount: Int
    
    public static func == (lhs: Movie,
                           rhs: Movie) -> Bool {
        lhs.id == rhs.id
    }
}
