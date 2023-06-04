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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        errorImageView.isHidden = true
    }
    
    func configure(with model: ProductViewModel) {
        model.getImage(imageView: self.imageView, errorImageView: self.errorImageView)
    }
}

extension ProductCell: ViewCode {
    func buildHierarchy() {
        self.contentView.addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(errorImageView)
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
        ])
        
    }
    
    func applyAdditionalChanges() {
        
    }
}
