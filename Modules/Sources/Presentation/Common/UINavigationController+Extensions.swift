//
//  UINavigationController+Extensions.swift
//
//
//  Created by Paulo Sigales on 03/06/23.
//

import UIKit

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
