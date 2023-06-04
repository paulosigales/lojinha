//
//  ProductCell.swift
//  
//
//  Created by Paulo Sigales on 03/06/23.
//


import UIKit

class ProductCell: UICollectionViewCell {
    private var model: ProductViewModel?
    
    private lazy var containerView: UIView = {
        return UIView().container()
    }()
    
    private lazy var imageView: UIImageView = {
        return UIImageView().productImage()
    }()
    
    private lazy var errorImageView: UIImageView = {
        return UIImageView().errorImage()
    }()
    
    private lazy var alphaView: UIView = {
        return UIView().alpha()
    }()
    
    private lazy var sizeStackView: UIStackView = {
        return UIStackView(axis: .vertical, spacing: 5)
    }()
    
    private lazy var onSaleTag = {
        return UIButton(text: "promo",
                        fontSize: 12,
                        width: 50,
                        height: 20,
                        isHidden: true,
                        isSelected: true)
    }()
    
    private lazy var actualPriceLabel: UILabel = {
        return UILabel(textColor: .customSecondary,
                       fontSize: 14,
                       fontWeight: .bold)
    }()
    
    private lazy var regularPriceLabel: UILabel = {
        return UILabel(textColor: .customDisabled, fontSize: 14)
    }()
    
    
    private lazy var nameLabel: UILabel = {
        return UILabel(textColor: .customText,
                       fontSize: 14,
                       textAlignment: .left)
    }()
    
    
    private func getSizeLabel(text: String) -> UILabel {
        return UILabel(text: text,
                       textColor: .white,
                       fontSize: 10,
                       fontWeight: .bold,
                       backgroundColor: .customSecondary,
                       corner: 5,
                       width: 20,
                       height: 15)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = ""
        actualPriceLabel.text = ""
        regularPriceLabel.text = ""
        imageView.image = nil
        errorImageView.isHidden = true
        onSaleTag.isHidden = true
        
        sizeStackView.subviews.forEach { view in
            view.removeFromSuperview()
        }
    }
    
    func configure(with model: ProductViewModel) {
        model.getImage(imageView: self.imageView, errorImageView: self.errorImageView)
        
        actualPriceLabel.text = model.actualPrice
        
        if model.actualPrice != model.regularPrice {
            regularPriceLabel.attributedText = model.regularPriceStrike
            onSaleTag.isHidden = false
        }
        
        nameLabel.text = model.name.lowercased()
        
        model.sizes.filter{ model.sizeAvailable(size: $0) }.forEach {
            let sizeTag = UIButton(text: $0.size, width: 20, height: 20, isSelected: true)
            sizeStackView.addArrangedSubview(sizeTag)
        }
    }
}

extension ProductCell: ViewCode {
    func buildHierarchy() {
        self.contentView.addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(errorImageView)
        containerView.addSubview(alphaView)
        containerView.addSubview(sizeStackView)
        containerView.addSubview(onSaleTag)
        containerView.addSubview(regularPriceLabel)
        containerView.addSubview(actualPriceLabel)
        containerView.addSubview(nameLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            imageView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.7),
            
            errorImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            errorImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            errorImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            errorImageView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.7),
            
            alphaView.topAnchor.constraint(equalTo: imageView.topAnchor),
            alphaView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            alphaView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            alphaView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.7),
            
            sizeStackView.topAnchor.constraint(equalTo: alphaView.topAnchor, constant: 5),
            sizeStackView.trailingAnchor.constraint(equalTo: alphaView.trailingAnchor, constant: -5),
            
            onSaleTag.bottomAnchor.constraint(equalTo: alphaView.bottomAnchor, constant: -5),
            onSaleTag.leadingAnchor.constraint(equalTo: alphaView.leadingAnchor, constant: 5),
            
            actualPriceLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            actualPriceLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 5),
            
            regularPriceLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            regularPriceLabel.leadingAnchor.constraint(equalTo: actualPriceLabel.trailingAnchor, constant: 10),
            
            nameLabel.topAnchor.constraint(equalTo: actualPriceLabel.bottomAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 5),
            nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -5),
        ])
        
    }
    
    func applyAdditionalChanges() {
        
    }
}
