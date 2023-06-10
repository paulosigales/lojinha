//
//  UIApplication+Extensions.swift
//  
//
//  Created by Paulo Sigales on 06/06/23.
//

import UIKit

/**
 An extension to `UIApplication` that provides a utility method for retrieving the topmost view controller in the view hierarchy.
 
 The `topViewController(_:)` method returns the topmost view controller in the view hierarchy, starting from the specified base view controller. It handles different container view controller scenarios, including navigation controllers, tab bar controllers, and presented view controllers, recursively traversing the view controller hierarchy until the topmost view controller is found.

 - Parameters:
    - base: The base view controller to start the traversal. By default, it uses the root view controller of the key window.
 - Returns: The topmost view controller in the view hierarchy, or `nil` if no view controller is found.
 
 Usage:
 ```
 // Get the topmost view controller
 if let topViewController = UIApplication.topViewController() {
 // Use the top view controller for further actions
 ...
 }
 ```

 - Note: The `topViewController(_:)` method uses a recursive approach to handle different container view controller scenarios. It first checks if the base view controller is a navigation controller and continues the traversal with its visible view controller. If the base view controller is a tab bar controller, it checks the selected view controller. If the base view controller has a presented view controller, it continues the traversal with the presented view controller. If none of these conditions match, it returns the base view controller itself.
 */
extension UIApplication {
    static func topViewController(_ base: UIViewController? = UIApplication.shared.connectedScenes
        .compactMap { $0 as? UIWindowScene }
        .flatMap { $0.windows }
        .first { $0.isKeyWindow }?
        .rootViewController
    ) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        
        if let presented = base?.presentedViewController {
            return topViewController(presented)
        }
        
        return base
    }
}


