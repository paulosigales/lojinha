//
//  UIView+Extensions.swift
//  
//
//  Created by Paulo Sigales on 03/06/23.
//

import UIKit

/**
 An extension to `UIView` that provides a convenient method for configuring a container view.
 
 The `container(backgroundColor:width:height:)` method allows you to configure a container view with specific properties, such as background color, width, and height. It returns the modified view itself for chaining purposes.
 
 - Parameters:
   - backgroundColor: The background color of the container view.
   - width: The width of the container view.
   - height: The height of the container view.
 
 - Returns: The modified view itself.
 
 Usage:
 
 ```
 let containerView = UIView().container(backgroundColor: .customBackground, width: 200, height: 100)
 ```
 
 - Note: The `container(backgroundColor:width:height:)` method sets the provided background color, `translatesAutoresizingMaskIntoConstraints`, and `layer.masksToBounds` properties of the view. It also configures the width and height constraints of the view if the specified values are not equal to zero. The method then returns the modified view itself for convenient chaining of further configurations or assignments.
 
 - Requires: None.
 */

extension UIView {
    func container(backgroundColor: UIColor = .customBackground,
                   width: CGFloat = .zero,
                   height: CGFloat = .zero
    ) -> Self {
        self.layer.masksToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = backgroundColor
        
        if width != .zero {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if height != .zero {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
        return self
    }
}

/**
 An extension to `UIView` that provides a convenient method for configuring a view with alpha transparency and rounded corners.
 
 The `alpha(value:corner:)` method allows you to configure a view with a specified alpha value and rounded corner radius. It returns the modified view itself for chaining purposes.
 
 - Parameters:
   - value: The alpha value (transparency) of the view, ranging from 0.0 (fully transparent) to 1.0 (fully opaque).
   - corner: The radius of the view's rounded corners.
 
 - Returns: The modified view itself.
 
 Usage:
 
 ```
 let view = UIView().alpha(value: 0.2, corner: 10)
 ```
 
 - Note: The `alpha(value:corner:)` method sets the background color of the view using `UIColor.black.withAlphaComponent(_:)` to apply the specified transparency. It also sets `translatesAutoresizingMaskIntoConstraints` and `layer.cornerRadius` properties of the view. The method then returns the modified view itself for convenient chaining of further configurations or assignments.
 
 - Requires: None.
 */

extension UIView {
    func alpha(
        value: CGFloat = 0.05,
        corner: CGFloat = 15
    ) -> Self {
        self.backgroundColor = UIColor.black.withAlphaComponent(value)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = corner
        return self
    }
}

/**
 An extension to `UIView` that provides a convenient method for creating an empty cart view.
 
 The `emptyCart()` method allows you to create a view representing an empty cart. It configures the view with a background color, adds a stack view containing an image view and a label, and positions it in the center of the view. It returns the modified view itself for chaining purposes.
  
 - Returns: The modified view itself.
 
 Usage:
 
 ```
 let emptyCartView = UIView().emptyCart()
 ```
 
 - Note: The `emptyCart()` method sets the `translatesAutoresizingMaskIntoConstraints` and `backgroundColor` properties of the view. It creates a `UIStackView` with a vertical axis, spacing, distribution, and alignment. It then creates an image view with a cart symbol image and a label with the provided text. The image view and label are added as arranged subviews to the stack view. The stack view is added as a subview of the view. Auto layout constraints are applied to position the stack view in the center of the view. The method returns the modified view itself for convenient chaining of further configurations or assignments.
 
 */
extension UIView {
    func emptyCart() -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .customBackground
        
        let stackView = UIStackView(axis: .vertical, spacing: 10, distribution: .equalCentering, alignment: .center)
        
        let sizeConfig = UIImage.SymbolConfiguration(pointSize: 50)
        let image = UIImage(systemName: "cart")?
            .withConfiguration(sizeConfig)
            .withTintColor(UIColor.customSecondary, renderingMode: .alwaysOriginal)
        
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel(text: "sem produtos no carrinho", fontSize: 16, textAlignment: .center, height: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)
        
        self.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        return self
    }
}
