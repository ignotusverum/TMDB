//
//  Config.swift
//  TheMovies
//
//  Created by Mikhail Pchelnikov on 09/06/2018.
//  Copyright © 2018 Michael Pchelnikov. All rights reserved.
//

import Foundation

/// Constants and static data.
public struct Config {

    public static let apiKey = "c05c2c887d2a1f9068c56a73ce82e5ae"
    
    public static let maxQueriesHistoryCount = 10

    public struct URL {
        public static let base = "https://api.themoviedb.org/3"
        public static let basePoster = "https://image.tmdb.org/t/p"
    }
    
    public struct PosterSizes {
        public static let sizes: [Int] = [
            92,
            154,
            185,
            342,
            500,
            780
        ]
        public static func closest(to w: Int) -> Int {
            sizes.sorted { (a, b) -> Bool in
                (w - a) < (w - b)
            }.first!
        }
    }
    
    public struct Keys {
        public static let queriesHistory = "_queriesHistory"
    }
    
    public struct CellIdentifier {
        public struct MovieTable {
            public static let movieCell = "MovieItemCell"
            public static let historyCell = "HistoryItemCell"
        }
    }
}
