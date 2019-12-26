//
//  ThemeProtocol.swift
//  ThemeManager
//
//  Created by Giuseppe Lanza on 14/11/2019.
//  Copyright © 2019 MERLin Tech. All rights reserved.
//

/// This protocol should be adopted by those ViewControllers
///that are meant to be themed
public protocol Themed: UITraitEnvironment {
    func applyTheme()
}

public protocol ThemeProtocol: class {
    var appearanceRules: AppearanceRuleSet { get }
    
    var logoImage: UIImage { get }
    
    // MARK: Colors
    
    func color(forColorPalette colorPalette: ThemeColorPalette) -> UIColor
    
    // MARK: Fonts
    
    func font(forStyle style: ThemeFontStyle) -> UIFont
    func fontSize(forStyle style: ThemeFontStyle) -> CGFloat
    func kern(forStyle style: ThemeFontStyle) -> CGFloat
    
    // MARK: Labels
    
    @discardableResult
    func configure(label: UILabel, withStyle style: ThemeFontStyle, customizing: ((UILabel, ThemeProtocol) -> Void)?) -> UILabel
    
    // MARK: Buttons
    
    @discardableResult func configurePrimaryButton(button: UIButton, withTitleStyle style: ThemeFontStyle, customizing: ((UIButton, ThemeProtocol) -> Void)?) -> UIButton
    @discardableResult func configureSecondaryButton(button: UIButton, withTitleStyle style: ThemeFontStyle, customizing: ((UIButton, ThemeProtocol) -> Void)?) -> UIButton
}
