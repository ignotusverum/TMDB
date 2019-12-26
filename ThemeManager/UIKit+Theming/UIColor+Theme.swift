//
//  UIColor+Theme.swift
//  ThemeManager
//
//  Created by Giuseppe Lanza on 14/11/2019.
//  Copyright © 2019 MERLin Tech. All rights reserved.
//

extension UIColor {
    public static func color(forPalette palette: ThemeColorPalette, usingTheme theme: ThemeProtocol = ThemeContainer.defaultTheme) -> UIColor {
        return theme.color(forColorPalette: palette)
    }
}
