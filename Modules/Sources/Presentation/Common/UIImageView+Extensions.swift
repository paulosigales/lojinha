//
//  UIImageView+Extensions.swift
//  
//
//  Created by Paulo Sigales on 03/06/23.
//

import UIKit

/**
 An extension to `UIImageView` that provides a convenient method for configuring and customizing image views with a product image appearance.
 
 The `productImage(contentMode:corner:)` method sets the content mode, corner radius, and other properties of the image view to create a product image appearance.
 
 Usage:
 ```
 let imageView = UIImageView()
 
 // Create a product image appearance with scale aspect fit content mode and a corner radius of 15
 let productImageView = imageView.productImage(contentMode: .scaleAspectFit, corner: 15)
 
 // Use the configured image view for display or further customization
 ```
 */
extension UIImageView {
    func productImage(
        contentMode:UIView.ContentMode = .scaleAspectFit,
        corner:CGFloat = 15
    ) -> Self {
        self.contentMode = contentMode
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = corner
        return self
    }
}

/**
 An extension to `UIImageView` that provides a convenient method for configuring and customizing image views with an error placeholder image.
 
 The `errorImage(size:isHidden:)` method configures the image view to display an error placeholder image with optional size and visibility settings.
 
 Usage:
 ```
 let imageView = UIImageView()
 
 // Configure the image view to display an error placeholder image with a size of 40 and initially hidden
 let errorImageView = imageView.errorImage(size: 40, isHidden: true)
 
 // Use the configured image view for display or further customization
 ```
 
 - Requires: Swift 4.0 and later.
 */
extension UIImageView {
    func errorImage(
        size: CGFloat = 40,
        isHidden: Bool = true
    ) -> Self {
        self.contentMode = .center
        self.isHidden = isHidden
        self.translatesAutoresizingMaskIntoConstraints = false
        let sizeConfig = UIImage.SymbolConfiguration(pointSize: size)
        self.image = UIImage(systemName: "photo")?
            .withConfiguration(sizeConfig)
            .withTintColor(UIColor.lightGray, renderingMode: .alwaysOriginal)
        return self
    }
}

