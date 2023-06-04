//
//  UIView+Extensions.swift
//  
//
//  Created by Paulo Sigales on 03/06/23.
//

import UIKit

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
