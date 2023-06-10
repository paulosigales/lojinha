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
        CartViewModel.add(product: product, size: size, quantity: quantity)
    }
    
    /**
     Retrieves and sets the image for the product using Kingfisher.
     
     The `getImage` method retrieves the image for the associated `product` using Kingfisher, a popular image loading and caching library. It takes two parameters: `imageView` and `errorImageView`, which represent the UIImageView and UIView elements used for displaying the image and showing an error placeholder, respectively.
     
     - Parameters:
        - imageView: The UIImageView element used for displaying the product image.
        - errorImageView: The UIView element used as a placeholder in case of image loading errors.
     
     This method uses KingfisherManager.shared to access the shared Kingfisher manager instance. It calls the `getImage` function provided by KingfisherManager.shared, passing the `product.image` as the image URL, `imageView` as the target UIImageView, and `errorImageView` as the placeholder UIView in case of errors.
     
     - Note: Kingfisher handles the asynchronous loading and caching of the image. The `getImage` method encapsulates the logic to retrieve and set the image for the product using Kingfisher.
     */
    func getImage(imageView: UIImageView, errorImageView: UIView) {
        KingfisherManager.shared.getImage(image: self.product.image, imageView: imageView, errorImageView: errorImageView)
    }
}

