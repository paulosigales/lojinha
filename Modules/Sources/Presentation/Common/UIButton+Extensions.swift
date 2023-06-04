//
//  UIButton+Extensions.swift
//  
//
//  Created by Paulo Sigales on 04/06/23.
//

import UIKit

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

extension UIButton {
    func setEnabled(_ isEnabled: Bool, colors: (UIColor,UIColor) = (.customSecondary,.customDisabled)) {
        self.isEnabled = isEnabled
        self.isSelected = isEnabled
        self.layer.borderColor = UIColor.white.cgColor
        self.backgroundColor = self.isEnabled ? colors.0 : colors.1
    }
}

extension UIButton {
    func setSelected(_ isSelected: Bool, colors: (UIColor,UIColor) = (.customSecondary,.white)) {
        self.isSelected = isSelected
        self.layer.borderColor = colors.0.cgColor
        self.backgroundColor = self.isSelected ? colors.0 : colors.1
    }
}


