//
//  UIButton+Theme.swift
//  ThemeManager
//
//  Created by Giuseppe Lanza on 14/11/2019.
//  Copyright © 2019 MERLin Tech. All rights reserved.
//

public extension UIButton {
    func applyPrimaryButtonStyle(usingTheme theme: ThemeProtocol = ThemeContainer.defaultTheme, withTitleStyle style: ThemeFontStyle, customizing: ((UIButton, ThemeProtocol) -> Void)? = nil) {
        theme.configurePrimaryButton(button: self, withTitleStyle: style, customizing: customizing)
    }
    
    func applySecondaryButtonStyle(usingTheme theme: ThemeProtocol = ThemeContainer.defaultTheme, withTitleStyle style: ThemeFontStyle, customizing: ((UIButton, ThemeProtocol) -> Void)? = nil) {
        theme.configureSecondaryButton(button: self, withTitleStyle: style, customizing: customizing)
    }
}

public extension Array where Element: UIButton {
    func applyPrimaryButtonStyle(usingTheme theme: ThemeProtocol = ThemeContainer.defaultTheme, withTitleStyle style: ThemeFontStyle, customizing: ((UIButton, ThemeProtocol) -> Void)? = nil) {
        forEach {
            theme.configurePrimaryButton(button: $0, withTitleStyle: style, customizing: customizing)
        }
    }
    
    func applySecondaryButtonStyle(usingTheme theme: ThemeProtocol = ThemeContainer.defaultTheme, withTitleStyle style: ThemeFontStyle, customizing: ((UIButton, ThemeProtocol) -> Void)? = nil) {
        forEach {
            theme.configureSecondaryButton(button: $0, withTitleStyle: style, customizing: customizing)
        }
    }
}
