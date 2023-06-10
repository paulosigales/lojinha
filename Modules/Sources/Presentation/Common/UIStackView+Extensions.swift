//
//  UIStackView+Extensions.swift
//  
//
//  Created by Paulo Sigales on 04/06/23.
//

import UIKit

/**
 An extension to `UIStackView` that provides a convenient way to create and customize UIStackView instances.
 
 The `convenience init(...)` initializer allows you to create a UIStackView with various customizations, such as axis, spacing, distribution, alignment, background color, and visibility.
 
 - Parameters:
   - axis: The axis along which the arranged views are laid out.
   - spacing: The spacing between arranged views.
   - distribution: The distribution of arranged views along the stack view's axis. The default value is `.equalSpacing`.
   - alignment: The alignment of arranged views perpendicular to the stack view's axis. The default value is `.leading`.
   - backgroundColor: The background color of the stack view. The default value is `.clear`.
   - isHidden: A Boolean value indicating whether the stack view is hidden. The default value is `false`.
 
 
 Usage:
 
 ```swift
 let stackView = UIStackView(
     axis: .vertical,
     spacing: 10,
     distribution: .equalSpacing,
     alignment: .center,
     backgroundColor: .clear,
     isHidden: false
 )
 ```
 
 - Note: The `convenience init(...)` initializer allows you to quickly create and customize a UIStackView instance with common properties. It sets the provided values to the respective stack view properties, such as axis, spacing, distribution, alignment, background color, and visibility.
 */
extension UIStackView {
    convenience init(
        axis: NSLayoutConstraint.Axis,
        spacing: Double,
        distribution: UIStackView.Distribution = .equalSpacing,
        alignment: UIStackView.Alignment = .leading,
        backgroundColor: UIColor = .clear,
        isHidden: Bool = false
    ){
        self.init()
        self.axis = axis
        self.spacing = spacing
        self.translatesAutoresizingMaskIntoConstraints = false
        self.distribution = distribution
        self.alignment = alignment
        self.backgroundColor = backgroundColor
        self.isHidden = isHidden
    }
}

/**
 An extension to `UIStackView` that provides a convenient method for creating an amount selector UIStackView.
 
 The `amountSelector(itemSize:action:quantity:)` method creates a UIStackView with an amount selector layout. It includes buttons for decreasing and increasing the quantity, along with a label displaying the current quantity.
 
 - Parameters:
   - itemSize: The size of the buttons and label within the stack view.
   - action: The selector that will be called when the quantity changes.
   - quantity: The initial quantity value. The default value is `1`.
 
 - Returns: A UIStackView with the amount selector layout.
 
 Usage:
 
 ```swift
 let stackView = UIStackView().amountSelector(itemSize: 40, action: #selector(quantityChanged(_:)), quantity: 1)
 ```
 
 - Note: The `amountSelector(itemSize:action:quantity:)` method creates a horizontal UIStackView with buttons for decreasing and increasing the quantity, as well as a label displaying the current quantity. The buttons are created using the `UIButton` initializer, and the label is created using the `UILabel` initializer. The stack view is then populated with these views and returned.
 */
extension UIStackView {
    func amountSelector(itemSize: CGFloat,
                        action: Selector,
                        quantity: Int = 1
    ) -> UIStackView {

        let stackView = UIStackView(axis: .horizontal, spacing: 5, alignment: .center)

        let lessButton = UIButton(text: "-", fontSize: 20,
                                  fontWeight: .bold,
                                  width: itemSize,
                                  height: itemSize,
                                  tag: 1,
                                  isSelected: true,
                                  target: self,
                                  action: action)
        
        let quantityLabel = UILabel(text: "\(quantity)",
                                    fontSize: 16,
                                    width: itemSize,
                                    height: itemSize,
                                    tag: 2)
        
        let plussButton = UIButton(text: "+",
                                   fontSize: 20,
                                   fontWeight: .bold,
                                   width: itemSize,
                                   height: itemSize,
                                   tag: 3,
                                   isSelected: true,
                                   target: self,
                                   action: action)
        
        stackView.addArrangedSubview(lessButton)
        stackView.addArrangedSubview(quantityLabel)
        stackView.addArrangedSubview(plussButton)
        
        return stackView
    }
}
