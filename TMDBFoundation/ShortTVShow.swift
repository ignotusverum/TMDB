//
//  ShortTVShow.swift
//  TMDBFoundation
//
//  Created by Giuseppe Lanza on 15/11/2019.
//  Copyright © 2019 MERLin Tech. All rights reserved.
//

public protocol ShortTVShow {
    var showType: ShowType { get }
    var id: Int64 { get }
    var title: String { get }
    var overview: String { get }
    var posterPath: String? { get }
    var averageVote: Double { get }
    var voteCount: Int { get }
    var date: Date? { get }
    
    func posterURL(forWidth width: Int) -> URL?
}

public extension ShortTVShow {
    func posterURL(forWidth width: Int) -> URL? {
        guard let path = posterPath else { return nil }
        let w = Config.PosterSizes.closest(to: width)
        return URL(string: Config.URL.basePoster)?
            .appendingPathComponent("w\(w)")
            .appendingPathComponent(path)
    }
}

extension Movie: ShortTVShow {
    public var date: Date? { releaseDate }
    public var showType: ShowType { .movie }
}

extension TVSeries: ShortTVShow {
    public var date: Date? { nil }
    public var showType: ShowType { .tvSeries }
}
