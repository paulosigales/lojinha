//
//  UIImageView+Extensions.swift
//  
//
//  Created by Paulo Sigales on 03/06/23.
//

import UIKit

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
