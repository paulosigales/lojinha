//
//  OrderCell.swift
//  
//
//  Created by Paulo Sigales on 06/06/23.
//

import UIKit
import Domain

final class OrderCell: UITableViewCell {
    
    private var orderViewModel: OrderViewModel?
    private var productViewModel: ProductViewModel?
    
    private lazy var imageContainerView = {
        return UIImageView().container()
    }()
    
    private lazy var productImageView = {
        return UIImageView().productImage(corner: 5)
    }()
    
    private lazy var errorImageView = {
        return UIImageView().errorImage(size: 20)
    }()
    
    private lazy var alphaView = {
        return UIView().alpha(corner: 5)
    }()
    
    private lazy var nameLabel = {
        return UILabel(textColor: .customText,
                       fontSize: 18,
                       textAlignment: .left)
    }()
    
    private lazy var sizeTag = {
        return UIButton(fontSize: 10, width: 20, height: 20, isSelected: true)
    }()
    
    private lazy var containerStackView: UIStackView = {
        return UIStackView(axis: .horizontal, spacing: 5)
    }()
    
    private lazy var quantitySelectorStackView: UIStackView = {
        return UIStackView().amountSelector(itemSize: 30, action: #selector(setQuantity))
    }()
    
    private lazy var priceLabel: UILabel = {
        return UILabel(textColor: .customSecondary,
                       fontSize: 18,
                       fontWeight: .bold,
                       fontFit: true,
                       height: 30)
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewCode()
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OrderCell {
    func configure(with orderViewModel: OrderViewModel, and productViewModel: ProductViewModel) {
        self.orderViewModel = orderViewModel
        self.productViewModel = productViewModel
        
        self.productViewModel?.getImage(imageView: self.productImageView, errorImageView: self.errorImageView)
        nameLabel.text = self.productViewModel?.name
        
        sizeTag.setTitle(self.orderViewModel?.size.size, for: .selected)
        setQuantityLabel(with: self.orderViewModel?.quantity ?? 0)
        priceLabel.text = self.orderViewModel?.priceTotalFormatted
    }
}

extension OrderCell {
    @objc private func setQuantity(sender:UIButton) {
        if self.orderViewModel?.quantity == 1 && sender.tag == 1 {
            self.removeItemAlert()
        }
        
        let quantityBy = sender.tag == 1 ? -1 : 1
        self.orderViewModel?.updateQuantity(by: quantityBy)
    }
    
    private func setQuantityLabel(with quantity: Int) {
        let quantityLabel = quantitySelectorStackView.viewWithTag(2) as! UILabel
        quantityLabel.text = "\(quantity)"
    }
    
    private func removeItemAlert() {
        guard let product = orderViewModel?.product,
              let size = orderViewModel?.size else {
            return
        }
        
        let alert = UIAlertController(title: "Remover",
                                      message: "Tem certeza que gostaria de remover o produto do carrinho?",
                                      cancelTitle: "Não",
                                      confirmTitle: "Sim") {
            self.removeItem(product: product, size: size)
        }
        
        UIApplication.topViewController()?.present(alert, animated: true)
    }
    
    private func removeItem(product: Product?, size: Size?) {
        guard let product = product,
              let size = size else {
            return
        }
        
        CartViewModel.removeOrder(withProduct: product, size: size)
    }
}

extension OrderCell: ViewCode {
    func buildHierarchy() {
        self.contentView.addSubview(imageContainerView)
        imageContainerView.addSubview(productImageView)
        imageContainerView.addSubview(errorImageView)
        imageContainerView.addSubview(alphaView)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(sizeTag)
        self.contentView.addSubview(containerStackView)
        containerStackView.addArrangedSubview(quantitySelectorStackView)
        containerStackView.addArrangedSubview(priceLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageContainerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imageContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            imageContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            imageContainerView.widthAnchor.constraint(equalToConstant: 110),
            
            productImageView.topAnchor.constraint(equalTo: self.imageContainerView.topAnchor),
            productImageView.leadingAnchor.constraint(equalTo: self.imageContainerView.leadingAnchor),
            productImageView.bottomAnchor.constraint(equalTo: self.imageContainerView.bottomAnchor),
            productImageView.widthAnchor.constraint(equalToConstant: 110),
            
            errorImageView.topAnchor.constraint(equalTo: self.imageContainerView.topAnchor),
            errorImageView.leadingAnchor.constraint(equalTo: self.imageContainerView.leadingAnchor),
            errorImageView.bottomAnchor.constraint(equalTo: self.imageContainerView.bottomAnchor),
            errorImageView.widthAnchor.constraint(equalToConstant: 110),
            
            alphaView.topAnchor.constraint(equalTo: self.imageContainerView.topAnchor),
            alphaView.leadingAnchor.constraint(equalTo: self.imageContainerView.leadingAnchor),
            alphaView.bottomAnchor.constraint(equalTo: self.imageContainerView.bottomAnchor),
            alphaView.widthAnchor.constraint(equalToConstant: 110),
            
            containerStackView.leadingAnchor.constraint(equalTo: imageContainerView.trailingAnchor, constant: 10),
            containerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            containerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            containerStackView.heightAnchor.constraint(equalToConstant: 40),
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            nameLabel.leadingAnchor.constraint(equalTo: imageContainerView.trailingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            sizeTag.topAnchor.constraint(equalTo: alphaView.topAnchor, constant: 5),
            sizeTag.trailingAnchor.constraint(equalTo: alphaView.trailingAnchor, constant: -5),
            
            
        ])
        
        let heightConstraint = imageContainerView.heightAnchor.constraint(equalToConstant: 120)
        heightConstraint.isActive = true
        heightConstraint.priority = UILayoutPriority.init(999)
    }
    
    func applyAdditionalChanges() {
        
    }
}
