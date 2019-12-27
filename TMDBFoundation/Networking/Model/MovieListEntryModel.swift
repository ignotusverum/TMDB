//
//  MovieListEntryModel.swift
//  TMDBFoundation
//
//  Created by Vlad Zagorodnyuk on 12/27/19.
//  Copyright © 2019 MERLin Tech. All rights reserved.
//

public protocol MovieListEntryModel: GenericEquatable {
    var id: Int64 { get }
    var title: String { get }
    var overview: String { get }
    var posterPath: String? { get }
    var releaseDate: Date? { get }
    var popularity: Double { get }
    var averageVote: Double { get }
    var voteCount: Int { get }
}
