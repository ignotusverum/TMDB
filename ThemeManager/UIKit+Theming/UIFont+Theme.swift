//
//  UIFont+Theme.swift
//  ThemeManager
//
//  Created by Giuseppe Lanza on 14/11/2019.
//  Copyright © 2019 MERLin Tech. All rights reserved.
//

public extension UIFont {
    static func font(forStyle style: ThemeFontStyle, usingTheme theme: ThemeProtocol = ThemeContainer.defaultTheme) -> UIFont {
        return theme.font(forStyle: style)
    }
}
