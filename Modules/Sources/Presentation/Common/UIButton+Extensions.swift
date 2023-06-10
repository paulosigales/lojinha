//
//  UIButton+Extensions.swift
//  
//
//  Created by Paulo Sigales on 04/06/23.
//

import UIKit

/**
 An extension to `UIButton` that provides a convenience initializer for creating a custom button with various properties.
 
 The `convenience init(...)` initializer creates a button with customizable properties such as text, font size, font weight, colors, corner radius, width, height, tag, and more. It allows you to easily create and configure a custom button.
 
 - Parameters:
    - text: The text to display on the button. Defaults to an empty string.
    - fontSize: The font size of the button's text. Defaults to 10.
    - fontWeight: The font weight of the button's text. Defaults to `.bold`.
    - textAlignment: The text alignment of the button's text. Defaults to `.center`.
    - colors: The colors to use for the button's background and text. Defaults to `(.customSecondary, .white)`.
    - corner: The corner radius of the button. Defaults to 5.
    - width: The width of the button. Defaults to zero, which uses the intrinsic content size.
    - height: The height of the button. Defaults to zero, which uses the intrinsic content size.
    - tag: An integer value that can be used to identify the button. Defaults to zero.
    - isHidden: A Boolean value that determines whether the button is hidden. Defaults to false.
    - isEnabled: A Boolean value that determines whether the button is enabled. Defaults to true.
    - isSelected: A Boolean value that determines whether the button is selected. Defaults to false.
    - target: The target object that receives the action message. Defaults to nil.
    - action: The selector representing the action message to send to the target. Defaults to nil.
    - Returns: A custom button with the specified properties.
 
 Usage:
 ```
 let customButton = UIButton(text: "Text",
                             fontSize: 16,
                             fontWeight: .bold,
                             textAlignment: .center,
                             colors: (.customSecondary, .white),
                             corner: 10,
                             width: 120,
                             height: 40,
                             tag: 0,
                             isHidden: false,
                             isEnabled: true,
                             isSelected: false,
                             target: self,
                             action: #selector(buttonTapped(_:)))
 
 // Add the custom button to a view
 view.addSubview(customButton)
 ```
 
 - Note: The `init(text:fontSize:fontWeight:textAlignment:colors:corner:width:height:tag:isHidden:isEnabled:isSelected:target:action:)` initializer creates a button with a custom appearance and behavior based on the provided parameters. You can customize the button's text, font, colors, corner radius, and more. The button can be configured to perform an action when tapped by specifying a target object and action selector.
 */
extension UIButton {
    
    convenience init(
        text: String = "",
        fontSize: Double = 10,
        fontWeight: UIFont.Weight = .bold,
        textAlignment: NSTextAlignment = .center,
        colors: (UIColor,UIColor) = (.customSecondary,.white),
        corner: CGFloat = 5,
        width: CGFloat = .zero,
        height: CGFloat = .zero,
        tag: Int = 0,
        isHidden: Bool = false,
        isEnabled: Bool = true,
        isSelected: Bool = false,
        target: Any? = nil,
        action: Selector? = nil
    ){
        self.init(type: .custom)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.setTitle(text, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        self.titleLabel?.textAlignment = textAlignment
        
        self.setTitleColor(colors.0, for: .normal)
        self.setTitleColor(colors.1, for: .selected)
        self.setTitleColor(colors.1, for: .disabled)
        
        self.clearsContextBeforeDrawing = false
        
        self.layer.cornerRadius = corner
        self.layer.borderColor = isSelected ? colors.1.cgColor : colors.0.cgColor
        self.layer.borderWidth = 1
        
        self.backgroundColor = isSelected ? colors.0 : colors.1
        
        if !isEnabled {
            self.backgroundColor = UIColor.customDisabled
            self.layer.borderColor = colors.1.cgColor
        }
        
        if width != .zero {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != .zero {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
        self.tag = tag
        
        self.isHidden = isHidden
        self.isSelected = isSelected
        self.isEnabled = isEnabled
        
        if let target = target, let action = action {
            self.addTarget(target, action: action, for: .touchUpInside)
        }
    }
}

/**
 An extension to `UIButton` that provides a method for enabling or disabling a button with custom appearance.
 
 The `setEnabled(_:colors:)` method allows you to enable or disable a button while customizing its appearance. It updates the button's enabled and selected state, border color, and background color based on the provided parameters.
 
 Usage:
 ```
 // Enable the button with custom colors
 customButton.setEnabled(true, colors: (.customSecondary, .customDisabled))
 
 // Disable the button with default colors
 customButton.setEnabled(false)
 ```
 
 - Parameters:
 - isEnabled: A Boolean value that determines whether the button should be enabled or disabled.
 - colors: The colors to use for the button's background in the enabled and disabled states. Defaults to `(.customSecondary, .customDisabled)`.
 
 - Note: The `setEnabled(_:colors:)` method updates the button's appearance to reflect the enabled or disabled state. It sets the button's enabled and selected state, border color, and background color based on the provided parameters.
  */

extension UIButton {
    func setEnabled(_ isEnabled: Bool, colors: (UIColor,UIColor) = (.customSecondary,.customDisabled)) {
        self.isEnabled = isEnabled
        self.isSelected = isEnabled
        self.layer.borderColor = UIColor.white.cgColor
        self.backgroundColor = self.isEnabled ? colors.0 : colors.1
    }
}

/**
 An extension to `UIButton` that provides a method for setting the selected state of a button with custom appearance.
 
 The `setSelected(_:colors:)` method allows you to set the selected state of a button while customizing its appearance. It updates the button's selected state, border color, and background color based on the provided parameters.
 
 Usage:
 ```
 // Set the button as selected with custom colors
 customButton.setSelected(true, colors: (.customSecondary, .white))
 
 // Set the button as unselected with default colors
 customButton.setSelected(false)
 ```
 
 - Parameters:
 - isSelected: A Boolean value that determines whether the button should be set as selected or unselected.
 - colors: The colors to use for the button's background in the selected and unselected states. Defaults to `(.customSecondary, .white)`.
 
 - Note: The `setSelected(_:colors:)` method updates the button's appearance to reflect the selected or unselected state. It sets the button's selected state, border color, and background color based on the provided parameters.
 */

extension UIButton {
    func setSelected(_ isSelected: Bool, colors: (UIColor,UIColor) = (.customSecondary,.white)) {
        self.isSelected = isSelected
        self.layer.borderColor = colors.0.cgColor
        self.backgroundColor = self.isSelected ? colors.0 : colors.1
    }
}

