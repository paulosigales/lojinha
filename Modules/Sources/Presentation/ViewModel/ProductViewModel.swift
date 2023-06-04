//
//  ProductViewModel.swift
//  
//
//  Created by Paulo Sigales on 03/06/23.
//

import UIKit
import Kingfisher
import Network
import Domain

struct ProductViewModel {
    let product: Product
    
    init(_ product: Product) {
        self.product = product
    }
    
    var name: String {
        return self.product.name.lowercased()
    }
    
    var actualPrice: String {
        return self.product.actualPrice
    }
    
    var regularPrice: String {
        return self.product.regularPrice
    }
    
    var regularPriceStrike: NSAttributedString {
        return self.product.regularPrice.strikeThrough()
    }
    
    var image : String {
        return self.product.image
    }
    
    var sizes : [Size] {
        return self.product.sizes
    }
    
    func sizeAvailable(size: Size) -> Bool {
        return size.available
    }
    
    func addToCart(product:Product, size: Size, quantity: Int) {
        
    }
    
    func getImage(imageView: UIImageView, errorImageView: UIView) {
        KingfisherManager.shared.getImage(image: self.product.image, imageView: imageView, errorImageView: errorImageView)
    }
}

