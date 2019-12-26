//
//  ThemeFontStyle.swift
//  ThemeManager
//
//  Created by Giuseppe Lanza on 14/11/2019.
//  Copyright © 2019 MERLin Tech. All rights reserved.
//

public enum ThemeFontAttribute: CaseIterable {
    case regular, bold, sBold, italic
}

public enum ThemeFontStyle: CaseIterable {
    case small(attribute: ThemeFontAttribute)
    case caption(attribute: ThemeFontAttribute)
    case subhead(attribute: ThemeFontAttribute)
    case body(attribute: ThemeFontAttribute)
    case headline(attribute: ThemeFontAttribute)
    case title(attribute: ThemeFontAttribute)
    case display(attribute: ThemeFontAttribute)
    case displayBig(attribute: ThemeFontAttribute)
    
    public var attribute: ThemeFontAttribute {
        switch self {
        case let .small(attribute): return attribute
        case let .caption(attribute): return attribute
        case let .subhead(attribute): return attribute
        case let .body(attribute): return attribute
        case let .headline(attribute): return attribute
        case let .title(attribute): return attribute
        case let .display(attribute): return attribute
        case let .displayBig(attribute): return attribute
        }
    }
    
    public static var allCases: [ThemeFontStyle] {
        return ThemeFontAttribute.allCases.flatMap {
            [
                .small(attribute: $0),
                .caption(attribute: $0),
                .subhead(attribute: $0),
                .body(attribute: $0),
                .headline(attribute: $0),
                .title(attribute: $0),
                .display(attribute: $0),
                .displayBig(attribute: $0)
            ]
        }
    }
}
