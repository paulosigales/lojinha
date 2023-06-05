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
