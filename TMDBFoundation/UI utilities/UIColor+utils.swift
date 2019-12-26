//
//  UIColor+utils.swift
//  moVimento
//
//  Created by Giuseppe Lanza on 07/09/2019.
//  Copyright © 2019 MERLin Tech. All rights reserved.
//

import UIKit

public extension UIColor {
    static func random() -> UIColor {
        let r = CGFloat.random(in: 0...1)
        let g = CGFloat.random(in: 0...1)
        let b = CGFloat.random(in: 0...1)
        return UIColor(red: r, green: g, blue: b, alpha: 1)
    }
}
