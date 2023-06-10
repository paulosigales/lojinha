//
//  UIActivityIndicator+Extensions
//  
//
//  Created by Paulo Sigales on 03/06/23.
//

import UIKit

/**
 An extension to `UIActivityIndicatorView` that provides a convenient method for configuring and customizing activity indicators with default settings.
 
 The `defaultIndicator()` method sets the color, style, and other properties of the activity indicator to create a default appearance.
 
 Usage:
 ```
 let activityIndicator = UIActivityIndicatorView().defaultIndicator()
 
 // Use the configured activity indicator for display or further customization
 ```
 
 - Note: The `defaultIndicator()` method sets the color, style, and other properties of the activity indicator to create a default appearance. It returns the modified activity indicator for convenience.
 */
extension UIActivityIndicatorView {
    func defaultIndicator() -> Self {
        self.color = UIColor.customSecondary
        self.style = .large
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
}
