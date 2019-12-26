//
//  ConfigureOperator.swift
//  TMDBFoundation
//
//  Created by Giuseppe Lanza on 14/11/2019.
//  Copyright © 2019 MERLin Tech. All rights reserved.
//

import Foundation

infix operator <~
public func <~<T>(instance: T, configurator: (inout T) -> Void) -> T {
    var mutable = instance
    configurator(&mutable)
    return mutable
}
