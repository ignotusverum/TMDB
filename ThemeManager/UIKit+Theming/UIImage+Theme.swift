//
//  UIImage+Theme.swift
//  ThemeManager
//
//  Created by Giuseppe Lanza on 14/11/2019.
//  Copyright © 2019 MERLin Tech. All rights reserved.
//

public extension UIImage {
    static func logoImage(usingTheme theme: ThemeProtocol = ThemeContainer.defaultTheme) -> UIImage {
        return theme.logoImage
    }
}
