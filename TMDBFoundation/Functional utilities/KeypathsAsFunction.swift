//
//  KeypathsAsFunction.swift
//  TMDBFoundation
//
//  Created by Giuseppe Lanza on 14/11/2019.
//  Copyright © 2019 MERLin Tech. All rights reserved.
//

import Foundation

prefix operator ^
public prefix func ^<Root, Value>(keyPath: KeyPath<Root, Value>) -> (Root) -> Value {
    return { root in
        root[keyPath: keyPath]
    }
}
