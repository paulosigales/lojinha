//
//  UINavigationController+Extensions.swift
//
//
//  Created by Paulo Sigales on 03/06/23.
//

import UIKit

/**
 An extension to `UINavigationController` that provides a convenient method for customizing the appearance of the navigation bar.
 
 The `setAppearance()` method sets the appearance of the navigation bar by configuring various properties such as prefersLargeTitles, background color, title text attributes, and tint color.
 
 Usage:
 
 ```
 let navigationController = UINavigationController()
 navigationController.setAppearance()
 ```
 
 - Note: The `setAppearance()` method configures the navigation bar to have large titles, sets the background color to `.customTertiary`, and sets the title text attributes and large title text attributes to have a foreground color of `.customPrimary`. It also sets the tint color to `.white` and applies the configured appearance to the standard, compact, and scroll edge appearances of the navigation bar.
 */
extension UINavigationController {
    func setAppearance() {
        self.navigationBar.prefersLargeTitles = false
        self.navigationItem.largeTitleDisplayMode = .never
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor.customTertiary
        appearance.titleTextAttributes = [.foregroundColor: UIColor.customPrimary]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.customPrimary]
        
        self.navigationBar.tintColor = .white
        self.navigationBar.standardAppearance = appearance
        self.navigationBar.compactAppearance = appearance
        self.navigationBar.scrollEdgeAppearance = appearance
    }
}
