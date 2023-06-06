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
