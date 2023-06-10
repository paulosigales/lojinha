//
//  UILabel+Extensions.swift
//  
//
//  Created by Paulo Sigales on 04/06/23.
//

import UIKit

/**
 An extension to `UILabel` that provides a convenient way to create and customize UILabel instances.
 
 The `convenience init(...)` initializer allows you to create a UILabel with various customizations, such as text, text color, font size, font weight, text alignment, background color, corner radius, width, height, and tag.
 
 - Parameters:
    - text: The text to be displayed by the label.
    - textColor: The color of the text. The default value is `.customText`.
    - fontSize: The size of the font for the text.
    - fontWeight: The weight of the font for the text. The default value is `.regular`.
    - fontFit: A Boolean value indicating whether the font size should be adjusted to fit the label's width. The default value is `false`.
    - textAlignment: The alignment of the text within the label. The default value is `.center`.
    - backgroundColor: The background color of the label. The default value is `.clear`.
    - corner: The corner radius of the label. The default value is `0`.
    - width: The width of the label. Use `.zero` for automatic width calculation. The default value is `.zero`.
    - height: The height of the label. Use `.zero` for automatic height calculation. The default value is `.zero`.
    - tag: An integer value that can be used to identify the label.
 
 
 Usage:
 
 ```
 let label = UILabel(text: "Hello World",
                    textColor: .black,
                    fontSize: 16,
                    fontWeight: .bold,
                    fontFit: true,
                    textAlignment: .center,
                    backgroundColor: .white,
                    corner: 5,
                    width: 200,
                    height: 40,
                    tag: 1)
 ```
 
 - Note: The `convenience init(...)` initializer allows you to quickly create and customize a UILabel instance with common properties. It sets the provided values to the respective label properties, such as text, text color, font, alignment, background color, corner radius, width, height, and tag. Auto layout constraints are also applied for the specified width and height values, if provided.
 */
extension UILabel{
    convenience init(
        text:String = "",
        textColor: UIColor = .customText,
        fontSize: Double,
        fontWeight: UIFont.Weight = .regular,
        fontFit: Bool = false,
        textAlignment: NSTextAlignment = .center,
        backgroundColor: UIColor = .clear,
        corner: CGFloat = 0,
        width: CGFloat = .zero,
        height: CGFloat = .zero,
        tag: Int = 0
    ){
        self.init()
        self.text = text
        self.layer.cornerRadius = corner
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.tag = tag
        self.font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.masksToBounds = true
        self.backgroundColor = backgroundColor
        self.adjustsFontSizeToFitWidth = fontFit
        
        if width != .zero {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if height != .zero {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}

