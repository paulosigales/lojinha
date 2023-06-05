//
//  UIBarButtonItem+Extensions.swift
//  
//
//  Created by Paulo Sigales on 05/06/23.
//

import UIKit

enum CartImage: CustomStringConvertible {
    case cart
    case cartEmpty
    
    var description: String {
        switch self {
            case .cart:
                return "cart.fill"
            case .cartEmpty:
                return "cart"
        }
    }
}

extension UIBarButtonItem {
    
    convenience init(withBadgeText badgeText: String,
                     cartImage: CartImage = .cart,
                     target: Any?,
                     action: Selector
    ){
        let sizeConfig = UIImage.SymbolConfiguration(pointSize: 20)
        let cartImage = UIImage(systemName: String(describing: cartImage))?
            .withConfiguration(sizeConfig)
            .withTintColor(UIColor.customSecondary, renderingMode: .alwaysOriginal)
        
        
        let cartButton = UIButton(type: .custom)
        cartButton.translatesAutoresizingMaskIntoConstraints = false
        cartButton.setImage(cartImage, for: .normal)
        cartButton.imageView?.contentMode = .scaleAspectFill
        cartButton.addTarget(target, action: action, for: .touchUpInside)
        
        let badgeLabel = UILabel()
        badgeLabel.text = badgeText
        badgeLabel.font = UIFont.boldSystemFont(ofSize: 12)
        badgeLabel.textColor = .white
        badgeLabel.backgroundColor = UIColor.customSecondary
        badgeLabel.textAlignment = .center
        badgeLabel.layer.cornerRadius = 12
        badgeLabel.clipsToBounds = true
        badgeLabel.translatesAutoresizingMaskIntoConstraints = false
        cartButton.addSubview(badgeLabel)
        
        NSLayoutConstraint.activate([
            cartButton.widthAnchor.constraint(equalToConstant: 80),
            badgeLabel.widthAnchor.constraint(equalToConstant: 24),
            badgeLabel.heightAnchor.constraint(equalToConstant: 24),
            badgeLabel.trailingAnchor.constraint(equalTo: cartButton.trailingAnchor, constant: 0),
            badgeLabel.centerYAnchor.constraint(equalTo: cartButton.centerYAnchor)
        ])
        
        self.init(customView: cartButton)
    }
}









