//
//  UIStackView+Extensions.swift
//  
//
//  Created by Paulo Sigales on 04/06/23.
//

import UIKit

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
