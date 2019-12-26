//
//  Theme.swift
//  TMDB
//
//  Created by Giuseppe Lanza on 14/11/2019.
//  Copyright © 2019 MERLin Tech. All rights reserved.
//

import ThemeManager

private extension ThemeColorPalette {
    var color: UIColor {
        switch self {
        case .white: return .color(fromHex: "#FFFFFF")
        case .gray: return .color(fromHex: "#737373")
        case .lightGray: return .color(fromHex: "#EFEFEF")
        case .black: return .color(fromHex: "#000000")
        case .primary: return .color(fromHex: "#143143")
        case .primaryFocused: return .color(fromHex: "#225575")
        case .accent: return .color(fromHex: "#FFC704")
        case .error: return .color(fromHex: "#E30613")
        case .warning: return .color(fromHex: "#FFC704")
        case .success: return .color(fromHex: "#287522")
        }
    }
}

private extension ThemeFontAttribute {
    func primaryFont(withSize size: CGFloat = UIFont.labelFontSize) -> UIFont {
        switch self {
        case .regular: return .systemFont(ofSize: size)
        case .bold: return .boldSystemFont(ofSize: size)
        case .sBold: return .systemFont(ofSize: size, weight: .semibold)
        case .italic: return .italicSystemFont(ofSize: size)
        }
    }
}

private extension ThemeFontStyle {
    var fontSize: CGFloat {
        switch self {
        case .small: return 11
        case .caption: return 12
        case .subhead: return 13
        case .body: return 15
        case .headline: return 18
        case .title: return 22
        case .display: return 26
        case .displayBig: return 50
        }
    }
    
    var font: UIFont {
        return attribute.primaryFont(withSize: fontSize)
    }
}

final class Theme: ThemeProtocol {
    func kern(forStyle style: ThemeFontStyle) -> CGFloat { 0 }
    
    var logoImage: UIImage { return UIImage() }
    
    lazy var appearanceRules: AppearanceRuleSet = {
        return AppearanceRuleSet {
            AppearanceRuleSet {
                UINavigationBar[\.barTintColor, .white]
                PropertyAppearanceRule<UINavigationBar, UIColor?>(keypath: \.tintColor, value: self.color(forColorPalette: .primary))
                UINavigationBar[\.titleTextAttributes, [
                    .font: self.font(forStyle: .caption(attribute: .regular)),
                    .foregroundColor: self.color(forColorPalette: .primary)
                    ]
                ]
            }
            
            AppearanceRuleSet {
                UITabBar[\.barTintColor, .white]
                UITabBarItem[\.badgeColor, self.color(forColorPalette: .error)]
                UITabBarItem[
                    get: { $0.titleTextAttributes(for: .selected) },
                    set: { $0.setTitleTextAttributes($1, for: .selected) },
                    value: [
                        NSAttributedString.Key.font: self.font(forStyle: .caption(attribute: .regular)),
                        NSAttributedString.Key.foregroundColor: self.color(forColorPalette: .black)
                    ]
                ]
            }
        }
    }()
    
    func color(forColorPalette colorPalette: ThemeColorPalette) -> UIColor {
        return colorPalette.color
    }
    
    func configurePrimaryButton(button: UIButton, withTitleStyle style: ThemeFontStyle, customizing: ((UIButton, ThemeProtocol) -> Void)?) -> UIButton {
        button.titleLabel?.font = style.font
        customizing?(button, self)
        return button
    }
    
    func configureSecondaryButton(button: UIButton, withTitleStyle style: ThemeFontStyle, customizing: ((UIButton, ThemeProtocol) -> Void)?) -> UIButton {
        button.titleLabel?.font = style.font
        customizing?(button, self)
        return button
    }
    
    
    func configure(label: UILabel, withStyle style: ThemeFontStyle, customizing: ((UILabel, ThemeProtocol) -> Void)?) -> UILabel {
        label.font = style.font
        customizing?(label, self)
        return label
    }
    
    func font(forStyle style: ThemeFontStyle) -> UIFont {
        return style.font
    }
    
    func fontSize(forStyle style: ThemeFontStyle) -> CGFloat {
        return style.fontSize
    }
    
    final func cleanThemeCopy() -> Theme {
        return Theme()
    }
}

