//
//  ProductViewController.swift
//  
//
//  Created by Paulo Sigales on 05/06/23.
//

import UIKit
import Combine
import Domain

class ProductViewController: UIViewController {
    private let viewModel: ProductViewModel
    private var quantity = 1
    private var sizeSelected: Size? = nil
    private var cancellable: AnyCancellable?
    
    private lazy var imageView: UIImageView = {
        return UIImageView().productImage()
    }()
    
    private lazy var errorImageView: UIImageView = {
        return UIImageView().errorImage()
    }()
    
    private lazy var alphaView: UIView = {
        return UIView().alpha()
    }()
    
    private lazy var onSaleTag = {
        return UIButton(text: "promo",
                        fontSize: 16,
                        width: 70,
                        height: 26,
                        isHidden: true,
                        isSelected: true)
    }()
    
    private lazy var actualPriceLabel: UILabel = {
        return UILabel(textColor: .customSecondary, fontSize: 20, fontWeight: .bold)
    }()
    
    private lazy var regularPriceLabel: UILabel = {
        return UILabel(textColor: .customDisabled, fontSize: 20)
    }()
    
    private lazy var nameLabel: UILabel = {
        return UILabel(textColor: .customText, fontSize: 18, textAlignment: .left)
    }()
    
    private lazy var sizeAndQuantityStackVIew: UIStackView = {
        return UIStackView(axis: .horizontal, spacing: 5)
    }()
    
    private lazy var sizeStackView: UIStackView = {
        return UIStackView(axis: .vertical, spacing: 5)
    }()
    
    private lazy var sizeLabelStackView: UILabel = {
        return UILabel(text:"tamanho:", fontSize: 16)
    }()
    
    private lazy var sizeTagStackView: UIStackView = {
        return UIStackView(axis: .horizontal, spacing: 5, distribution: .equalSpacing, alignment: .leading)
    }()
    
    private lazy var quantityStackView : UIStackView = {
        return UIStackView(axis: .vertical, spacing: 5, isHidden: true)
    }()
    
    private lazy var quantityLabel: UILabel = {
        return UILabel(text:"quantidade:", fontSize: 16)
    }()
    
    private lazy var addToCartButton: UIButton = {
        return UIButton(text:"adicionar ao carrinho",
                        fontSize: 16,
                        fontWeight: .bold,
                        height: 50,
                        isEnabled: false,
                        target: self, action: #selector(addToCart))
    }()
    
    private lazy var quantitySelectorStackView: UIStackView = {
        return UIStackView().amountSelector(itemSize: 40, action: #selector(setQuantity))
    }()
    
    init(viewModel: ProductViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setupViewCode()
        
    }
}

extension ProductViewController {
    func configureView() {
        viewModel.getImage(imageView: self.imageView, errorImageView: self.errorImageView)
        
        nameLabel.text = viewModel.name.lowercased()
        
        configurePrice()
        
        configureSizeTags()
        
    }
    
    func configurePrice() {
        actualPriceLabel.text = viewModel.actualPrice
        
        if viewModel.actualPrice != viewModel.regularPrice {
            regularPriceLabel.attributedText = viewModel.regularPriceStrike
            onSaleTag.isHidden = false
        }
    }
    
    func configureSizeTags() {
        viewModel.sizes.enumerated().filter{ viewModel.sizeAvailable(size: $1) }.forEach {
            let sizeTag = UIButton(text: $1.size,
                                   fontSize: 16,
                                   width: 40,
                                   height: 40,
                                   tag: $0,
                                   target: self,
                                   action: #selector(selectSize))
            sizeTagStackView.addArrangedSubview(sizeTag)
        }
        
        if sizeTagStackView.subviews.count == 1,
           let button = sizeTagStackView.subviews.first as? UIButton {
            selectSize(sender: button)
        }
    }
}

extension ProductViewController {
    
    @objc private func selectSize(sender:UIButton) {
        deselectAllSizeTags()
        
        let button = sender as UIButton
        button.setSelected(!sender.isSelected)
        self.sizeSelected = viewModel.sizes[button.tag]
        
        quantity = 1
        quantityStackView.isHidden = false
        setQuantityLabel(with: quantity)
        addToCartButton.isHidden = false
        
        addToCartButton.setSelected(true)
        addToCartButton.setEnabled(true)
    }
    
    private func deselectAllSizeTags() {
        sizeTagStackView.subviews.forEach {
            if let tag = $0 as? UIButton {
                tag.setSelected(false)
            }
        }
    }
    
    @objc private func setQuantity(sender:UIButton) {
        let amount = sender.tag == 1 ? -1 : 1
        let newQuantity = quantity + amount
        if newQuantity >= 1 {
            quantity = newQuantity
        }
        
        setQuantityLabel(with: quantity)
    }
    
    private func setQuantityLabel(with quantity: Int) {
        let quantityLabel = quantitySelectorStackView.viewWithTag(2) as! UILabel
        quantityLabel.text = "\(quantity)"
    }
    
    @objc private func addToCart(sender:UIButton) {
        guard let sizeSelected = sizeSelected else { return }
        viewModel.addToCart(product: viewModel.product, size: sizeSelected, quantity: quantity)
        self.dismiss(animated: true)
    }
}

extension ProductViewController: ViewCode {
    func buildHierarchy() {
        view.addSubview(imageView)
        view.addSubview(errorImageView)
        view.addSubview(alphaView)
        view.addSubview(onSaleTag)
        view.addSubview(actualPriceLabel)
        view.addSubview(regularPriceLabel)
        view.addSubview(nameLabel)
        view.addSubview(sizeAndQuantityStackVIew)
        sizeAndQuantityStackVIew.addArrangedSubview(sizeStackView)
        sizeAndQuantityStackVIew.addArrangedSubview(quantityStackView)
        sizeStackView.addArrangedSubview(sizeLabelStackView)
        sizeStackView.addArrangedSubview(sizeTagStackView)
        quantityStackView.addArrangedSubview(quantityLabel)
        quantityStackView.addArrangedSubview(quantitySelectorStackView)
        view.addSubview(addToCartButton)
    }
    
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.65),
            
            errorImageView.topAnchor.constraint(equalTo: view.topAnchor),
            errorImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            errorImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.65),
            
            alphaView.topAnchor.constraint(equalTo: view.topAnchor),
            alphaView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            alphaView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            alphaView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.65),
            
            onSaleTag.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            onSaleTag.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            
            actualPriceLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            actualPriceLabel.leadingAnchor.constraint(equalTo: onSaleTag.isHidden ? view.leadingAnchor : onSaleTag.trailingAnchor, constant: 10),
            
            regularPriceLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            regularPriceLabel.leadingAnchor.constraint(equalTo: actualPriceLabel.trailingAnchor, constant: 10),
            
            nameLabel.topAnchor.constraint(equalTo: actualPriceLabel.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            sizeAndQuantityStackVIew.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            sizeAndQuantityStackVIew.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            sizeAndQuantityStackVIew.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            addToCartButton.topAnchor.constraint(equalTo: sizeAndQuantityStackVIew.bottomAnchor, constant: 20),
            addToCartButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            addToCartButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }
    
    func applyAdditionalChanges() {
        view.backgroundColor = UIColor.customBackground
    }
}

