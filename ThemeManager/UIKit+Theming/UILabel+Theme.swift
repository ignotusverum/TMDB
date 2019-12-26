//
//  UILabel+Theme.swift
//  ThemeManager
//
//  Created by Giuseppe Lanza on 14/11/2019.
//  Copyright © 2019 MERLin Tech. All rights reserved.
//

public extension UILabel {
    func applyLabelStyle(_ style: ThemeFontStyle, usingTheme theme: ThemeProtocol = ThemeContainer.defaultTheme, customizing: ((UILabel, ThemeProtocol) -> Void)? = nil) {
        theme.configure(label: self, withStyle: style, customizing: customizing)
    }
}

public extension Array where Element: UILabel {
    func applyLabelStyle(_ style: ThemeFontStyle, usingTheme theme: ThemeProtocol = ThemeContainer.defaultTheme, customizing: ((UILabel, ThemeProtocol) -> Void)? = nil) {
        forEach {
            theme.configure(label: $0, withStyle: style, customizing: customizing)
        }
    }
}
