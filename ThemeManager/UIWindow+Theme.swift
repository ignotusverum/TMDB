//
//  UIWindow+Theme.swift
//  ThemeManager
//
//  Created by Giuseppe Lanza on 14/11/2019.
//  Copyright © 2019 MERLin Tech. All rights reserved.
//

public extension UIWindow {
    func applyTheme(_ theme: ThemeProtocol) {
        theme.appearanceRules.apply()
        for view in subviews {
            view.removeFromSuperview()
            addSubview(view)
        }
        
        guard let root = rootViewController else { return }
        UIWindow.traverseViewControllerStackApplyingTheme(from: root)
    }
    
    static func traverseViewControllerStackApplyingTheme(from root: UIViewController) {
        // Standard BFS traversal.
        var queue = Set([root])
        var visited = Set<UIViewController>()
        
        while let controller = queue.first {
            queue.removeFirst()
            visited.insert(controller)
            (controller as? Themed)?.applyTheme()
            controller.children.forEach { queue.insert($0) }
            if let presented = controller.presentedViewController,
                !visited.contains(presented) {
                queue.insert(presented)
            }
        }
    }
}

@objc public extension UIWindow {
    func applyDefaultTheme(overrideLocal: Bool) {
        applyTheme(ThemeContainer.defaultTheme)
    }
}
