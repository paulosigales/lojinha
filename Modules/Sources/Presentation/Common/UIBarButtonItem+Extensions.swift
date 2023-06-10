//
//  UIBarButtonItem+Extensions.swift
//  
//
//  Created by Paulo Sigales on 05/06/23.
//

import UIKit

/**
 An enumeration that represents different cart images.
 
 The `CartImage` enum provides two cases: `.cart` and `.cartEmpty`, which represent different cart images. It conforms to the `CustomStringConvertible` protocol, allowing you to get a textual description of each case.
 
 Usage:
 ```
 let cartImage = CartImage.cart
 
 // Get the description of the cart image
 let description = cartImage.description
 
 // Use the description for display or further processing
 ...
 ```
 
 - Note: The `CartImage` enum provides a computed property `description` that returns the corresponding image name for each case. The `.cart` case returns "cart.fill" and the `.cartEmpty` case returns "cart".
 */
enum CartImage: CustomStringConvertible {
    case cart
    case cartEmpty
    
    var description: String {
        switch self {
            case .cart:
                return "cart.fill"
            case .cartEmpty:
                return "cart"
        }
    }
}

/**
 An extension to `UIBarButtonItem` that provides a convenience initializer for creating a bar button item with a badge text and cart image.
 
 The `withBadgeText(_:cartImage:target:action:)` initializer creates a bar button item with a custom view consisting of a cart image and a badge label. It allows you to easily display a badge text on the cart image. You can customize the cart image, target, and action as needed.
 
 - Parameters:
    - badgeText: The text to display as a badge on the cart image.
    - cartImage: The cart image to use for the bar button item. Defaults to `.cart`.
    - target: The target object that receives the action message.
    - action: The selector representing the action message to send to the target.
    - Returns: A bar button item with a custom view consisting of a cart image and a badge label.
 
 Usage:
 ```
 let cartButton = UIBarButtonItem(withBadgeText: "3",
 cartImage: .cart,
 target: self,
 action: #selector(cartButtonTapped(_:)))
 
 // Use the created bar button item in a navigation bar
 navigationItem.rightBarButtonItem = cartButton
 ```
 
 - Note: The `withBadgeText(_:cartImage:target:action:)` initializer creates a custom view using a `UIButton` with a cart image and a `UILabel` for the badge. The badge label displays the specified badge text and has a circular shape with a background color of `.customSecondary`. The badge label is positioned at the top-right corner of the cart image.
 */

extension UIBarButtonItem {
    
    convenience init(withBadgeText badgeText: String,
                     cartImage: CartImage = .cart,
                     target: Any?,
                     action: Selector
    ){
        let sizeConfig = UIImage.SymbolConfiguration(pointSize: 20)
        let cartImage = UIImage(systemName: String(describing: cartImage))?
            .withConfiguration(sizeConfig)
            .withTintColor(UIColor.customSecondary, renderingMode: .alwaysOriginal)
        
        
        let cartButton = UIButton(type: .custom)
        cartButton.translatesAutoresizingMaskIntoConstraints = false
        cartButton.setImage(cartImage, for: .normal)
        cartButton.imageView?.contentMode = .scaleAspectFill
        cartButton.addTarget(target, action: action, for: .touchUpInside)
        
        let badgeLabel = UILabel()
        badgeLabel.text = badgeText
        badgeLabel.font = UIFont.boldSystemFont(ofSize: 12)
        badgeLabel.textColor = .white
        badgeLabel.backgroundColor = UIColor.customSecondary
        badgeLabel.textAlignment = .center
        badgeLabel.layer.cornerRadius = 12
        badgeLabel.clipsToBounds = true
        badgeLabel.translatesAutoresizingMaskIntoConstraints = false
        cartButton.addSubview(badgeLabel)
        
        NSLayoutConstraint.activate([
            cartButton.widthAnchor.constraint(equalToConstant: 80),
            badgeLabel.widthAnchor.constraint(equalToConstant: 24),
            badgeLabel.heightAnchor.constraint(equalToConstant: 24),
            badgeLabel.trailingAnchor.constraint(equalTo: cartButton.trailingAnchor, constant: 0),
            badgeLabel.centerYAnchor.constraint(equalTo: cartButton.centerYAnchor)
        ])
        
        self.init(customView: cartButton)
    }
}
