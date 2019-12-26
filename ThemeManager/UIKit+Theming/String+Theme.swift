//
//  String+Theme.swift
//  ThemeManager
//
//  Created by Giuseppe Lanza on 14/11/2019.
//  Copyright © 2019 MERLin Tech. All rights reserved.
//

public struct StringAttributes {
    let attr: [NSAttributedString.Key: Any]
    
    public init(attr: [NSAttributedString.Key: Any]) {
        self.attr = attr
    }
    
    public static let empty = StringAttributes(attr: [:])
    
    public static func + (lhs: StringAttributes, rhs: StringAttributes) -> StringAttributes {
        StringAttributes(attr: lhs.attr.merging(rhs.attr) { _, new in new })
    }
}

public func foregroundColor(_ color: UIColor) -> StringAttributes {
    StringAttributes(attr: [.foregroundColor: color])
}

public func foregroundColor(_ palette: ThemeColorPalette, usingTheme theme: ThemeProtocol = ThemeContainer.defaultTheme) -> StringAttributes {
    foregroundColor(theme.color(forColorPalette: palette))
}

public func background(_ color: UIColor) -> StringAttributes {
    StringAttributes(attr: [.backgroundColor: color])
}

public func background(_ color: ThemeColorPalette, usingTheme theme: ThemeProtocol = ThemeContainer.defaultTheme) -> StringAttributes {
    background(theme.color(forColorPalette: color))
}

public func underline(color: UIColor) -> StringAttributes {
    StringAttributes(attr: [.underlineColor: color])
}

public func underline(color: ThemeColorPalette, usingTheme theme: ThemeProtocol = ThemeContainer.defaultTheme) -> StringAttributes {
    underline(theme.color(forColorPalette: color))
}

public func underline(style: NSUnderlineStyle) -> StringAttributes {
    StringAttributes(attr: [.underlineStyle: style.rawValue])
}

public func underline(_ color: UIColor, style: NSUnderlineStyle = .single) -> StringAttributes {
    underline(color: color) + underline(style: style)
}

public func underline(_ color: ThemeColorPalette, style: NSUnderlineStyle = .single, usingTheme theme: ThemeProtocol = ThemeContainer.defaultTheme) -> StringAttributes {
    underline(theme.color(forColorPalette: color)) + underline(style: style)
}

public func font(_ font: UIFont, withKern kern: CGFloat = 0) -> StringAttributes {
    StringAttributes(attr: [.font: font, .kern: kern])
}

public func font(forStyle style: ThemeFontStyle, kerned: Bool = false, usingTheme theme: ThemeProtocol = ThemeContainer.defaultTheme) -> StringAttributes {
    font(theme.font(forStyle: style), withKern: kerned ? theme.kern(forStyle: style) : 0)
}

public func shadow(_ shadow: NSShadow) -> StringAttributes {
    StringAttributes(attr: [.shadow: shadow])
}

public func baselineOffset(_ offset: CGFloat) -> StringAttributes {
    StringAttributes(attr: [.baselineOffset: offset])
}

public func strikethroughStyle(_ style: NSUnderlineStyle = .single) -> StringAttributes {
    StringAttributes(attr: [NSAttributedString.Key.strikethroughStyle: style.rawValue])
}

public func paragraphStyle(_ style: NSMutableParagraphStyle) -> StringAttributes {
    StringAttributes(attr: [NSAttributedString.Key.paragraphStyle: style])
}

public extension StringProtocol {
    func foregroundColor(_ color: UIColor) -> NSAttributedString {
        NSAttributedString(string: String(self)) { ThemeManager.foregroundColor(color) }
    }
    
    func foregroundColor(_ color: ThemeColorPalette, usingTheme theme: ThemeProtocol = ThemeContainer.defaultTheme) -> NSAttributedString {
        NSAttributedString(string: String(self)) { ThemeManager.foregroundColor(color, usingTheme: theme) }
    }
    
    func background(_ color: UIColor) -> NSAttributedString {
        NSAttributedString(string: String(self)) { ThemeManager.background(color) }
    }
    
    func background(_ color: ThemeColorPalette, usingTheme theme: ThemeProtocol = ThemeContainer.defaultTheme) -> NSAttributedString {
        NSAttributedString(string: String(self)) { ThemeManager.background(color, usingTheme: theme) }
    }
    
    func underline(_ color: UIColor, style: NSUnderlineStyle = .single) -> NSAttributedString {
        NSAttributedString(string: String(self)) { ThemeManager.underline(color, style: style) }
    }
    
    func underline(_ color: ThemeColorPalette, style: NSUnderlineStyle = .single, usingTheme theme: ThemeProtocol = ThemeContainer.defaultTheme) -> NSAttributedString {
        NSAttributedString(string: String(self)) { ThemeManager.underline(color, style: style, usingTheme: theme) }
    }
    
    func font(_ font: UIFont, withKern kern: CGFloat = 0) -> NSAttributedString {
        NSAttributedString(string: String(self)) { ThemeManager.font(font, withKern: kern) }
    }
    
    func font(forStyle style: ThemeFontStyle, kerned: Bool = false, usingTheme theme: ThemeProtocol = ThemeContainer.defaultTheme) -> NSAttributedString {
        NSAttributedString(string: String(self)) { ThemeManager.font(forStyle: style, kerned: kerned, usingTheme: theme) }
    }
    
    func shadow(_ shadow: NSShadow) -> NSAttributedString {
        NSAttributedString(string: String(self)) { ThemeManager.shadow(shadow) }
    }
    
    func baselineOffset(_ offset: CGFloat) -> NSAttributedString {
        NSAttributedString(string: String(self)) { ThemeManager.baselineOffset(offset) }
    }
    
    func strikethroughStyle(_ style: NSUnderlineStyle = .single) -> NSAttributedString {
        NSAttributedString(string: String(self)) { ThemeManager.strikethroughStyle(style) }
    }
    
    func paragraphStyle(_ style: NSMutableParagraphStyle) -> NSAttributedString {
        NSAttributedString(string: String(self)) { ThemeManager.paragraphStyle(style) }
    }
    
    var attributed: NSAttributedString {
        NSAttributedString(string: String(self))
    }
}

public extension NSAttributedString {
    func apply(@NSAttributesBuilder attributes: () -> StringAttributes) -> NSAttributedString {
        let mutable = NSMutableAttributedString(string: string, attributes: self.attributes(at: 0, effectiveRange: nil))
        mutable.addAttributes(attributes().attr, range: NSMakeRange(0, (string as NSString).length))
        return mutable
    }
    
    func foregroundColor(_ color: UIColor) -> NSAttributedString {
        apply { ThemeManager.foregroundColor(color) }
    }
    
    func foregroundColor(_ color: ThemeColorPalette, usingTheme theme: ThemeProtocol = ThemeContainer.defaultTheme) -> NSAttributedString {
        apply { ThemeManager.foregroundColor(color, usingTheme: theme) }
    }
    
    func background(_ color: UIColor) -> NSAttributedString {
        apply { ThemeManager.background(color) }
    }
    
    func background(_ color: ThemeColorPalette, usingTheme theme: ThemeProtocol = ThemeContainer.defaultTheme) -> NSAttributedString {
        apply { ThemeManager.background(color, usingTheme: theme) }
    }
    
    func underline(_ color: UIColor, style: NSUnderlineStyle = .single) -> NSAttributedString {
        apply { ThemeManager.underline(color, style: style) }
    }
    
    func underline(_ color: ThemeColorPalette, style: NSUnderlineStyle = .single, usingTheme theme: ThemeProtocol = ThemeContainer.defaultTheme) -> NSAttributedString {
        apply { ThemeManager.underline(color, style: style, usingTheme: theme) }
    }
    
    func font(_ font: UIFont, withKern kern: CGFloat = 0) -> NSAttributedString {
        apply { ThemeManager.font(font, withKern: kern) }
    }
    
    func font(forStyle style: ThemeFontStyle, kerned: Bool = false, usingTheme theme: ThemeProtocol = ThemeContainer.defaultTheme) -> NSAttributedString {
        apply { ThemeManager.font(forStyle: style, kerned: kerned, usingTheme: theme) }
    }
    
    func shadow(_ shadow: NSShadow) -> NSAttributedString {
        apply { ThemeManager.shadow(shadow) }
    }
    
    func baselineOffset(_ offset: CGFloat) -> NSAttributedString {
        apply { ThemeManager.baselineOffset(offset) }
    }
    
    func strikethroughStyle(_ style: NSUnderlineStyle = .single) -> NSAttributedString {
        apply { ThemeManager.strikethroughStyle(style) }
    }
    
    func paragraphStyle(_ style: NSMutableParagraphStyle) -> NSAttributedString {
        apply { ThemeManager.paragraphStyle(style) }
    }
}

@_functionBuilder
public struct NSAttributesBuilder {
    public static func buildBlock(_ attributes: StringAttributes...) -> StringAttributes {
        attributes.reduce(.empty, +)
    }
    
    public static func buildIf(_ attribute: StringAttributes?) -> StringAttributes {
        attribute ?? .empty
    }
    
    public static func buildEither(first: StringAttributes) -> StringAttributes {
        first
    }
    
    public static func buildEither(second: StringAttributes) -> StringAttributes {
        second
    }
}

@_functionBuilder
public struct AttributedStringBuilder {
    public static func buildBlock(_ segments: NSAttributedString...) -> NSAttributedString {
        segments.reduce(into: NSMutableAttributedString()) { $0.append($1) }
    }
    
    public static func buildIf(_ segment: NSAttributedString?) -> NSAttributedString {
        segment ?? NSAttributedString()
    }
    
    public static func buildEither(first: NSAttributedString) -> NSAttributedString {
        first
    }
    
    public static func buildEither(second: NSAttributedString) -> NSAttributedString {
        second
    }
}

public extension NSAttributedString {
    convenience init(@AttributedStringBuilder _ content: () -> NSAttributedString) {
        self.init(attributedString: content())
    }
    
    convenience init(string: String, @NSAttributesBuilder attributes: () -> StringAttributes) {
        self.init(string: string, attributes: attributes().attr)
    }
    
    func addingAttributes(forRange range: NSRange, @NSAttributesBuilder attributes: () -> StringAttributes) -> NSAttributedString {
        let res = NSMutableAttributedString(attributedString: self)
        res.addAttributes(attributes().attr, range: range)
        return res
    }
}

public extension NSMutableAttributedString {
    func addAttributes(forRange range: NSRange, @NSAttributesBuilder attributes: () -> StringAttributes) {
        addAttributes(attributes().attr, range: range)
    }
}
