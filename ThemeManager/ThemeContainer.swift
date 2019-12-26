//
//  ThemeManager.swift
//  ThemeManager
//
//  Created by Giuseppe Lanza on 14/11/2019.
//  Copyright © 2019 MERLin Tech. All rights reserved.
//

public class ThemeContainer {
    public static var defaultTheme: ThemeProtocol! {
        didSet {
            if let old = oldValue {
                old.appearanceRules.revert()
            }
            
            UIApplication.shared.windows.forEach { window in
                window.applyTheme(defaultTheme)
            }
        }
    }
}
