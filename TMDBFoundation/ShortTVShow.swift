//
//  ShortTVShow.swift
//  TMDBFoundation
//
//  Created by Giuseppe Lanza on 15/11/2019.
//  Copyright © 2019 MERLin Tech. All rights reserved.
//

public struct ShortTVShow {
    public var id: Int64
    public var title: String
    public var overview: String
    public var posterPath: String?
    public var averageVote: Double
    public var voteCount: Int
    public var date: Date?
    
    public init(model: MovieListEntryModel) {
        id = model.id
        title = model.title
        overview = model.overview
        posterPath = model.posterPath
        averageVote = model.averageVote
        voteCount = model.voteCount
        date = model.releaseDate
    }
    
    public func posterURL(forWidth width: Int) -> URL? {
        guard let path = posterPath else { return nil }
        let w = Config.PosterSizes.closest(to: width)
        return URL(string: Config.URL.basePoster)?
            .appendingPathComponent("w\(w)")
            .appendingPathComponent(path)
    }
}
