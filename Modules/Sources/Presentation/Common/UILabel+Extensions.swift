//
//  UILabel+Extensions.swift
//  
//
//  Created by Paulo Sigales on 04/06/23.
//

import UIKit

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

