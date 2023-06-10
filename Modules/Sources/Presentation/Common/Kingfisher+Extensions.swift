//
//  Kingfisher+Extensions.swift
//  
//
//  Created by Paulo Sigales on 03/06/23.
//

import UIKit
import Kingfisher

/**
 An extension to `KingfisherManager` that provides a convenient method for retrieving and displaying images using Kingfisher library.
 
 The `getImage(image:imageView:errorImageView:)` method retrieves an image from the specified URL using Kingfisher's image retrieval functionality. It sets the retrieved image to the specified image view and handles error scenarios by hiding/showing the image view and an optional error image view.
 
 - Parameters:
   - image: The URL of the image to retrieve.
   - imageView: The `UIImageView` where the retrieved image will be displayed.
   - errorImageView: An optional `UIView` that represents an error view to be shown if image retrieval fails.
 
 Usage:
 ```
 let imageManager = KingfisherManager.shared
 let imageView = UIImageView()
 let errorImageView = UIView()
 let imageURL = "https://example.com/image.jpg"
 
 // Retrieve and display the image using Kingfisher
 imageManager.getImage(image: imageURL, imageView: imageView, errorImageView: errorImageView)
 ```
 
 - Note: The `getImage(image:imageView:errorImageView:)` method uses Kingfisher's `retrieveImage(with:completionHandler:)` method to retrieve the image asynchronously. Upon success, it sets the retrieved image to the specified image view after applying the `trim()` method from the `UIImage` extension. It also handles error scenarios by hiding/showing the image view and the error image view accordingly.
 
 - Requires: Kingfisher library must be imported. You can find it at [https://github.com/onevcat/Kingfisher.git](https://github.com/onevcat/Kingfisher.git).
 */
extension KingfisherManager {
    public func getImage(image:String, imageView: UIImageView, errorImageView: UIView) {
        if let url = URL(string: image) {
            self.retrieveImage(with: url) { result in
                switch result {
                    case .success(let value):
                        imageView.image = value.image.trim()
                        imageView.isHidden = false
                        errorImageView.isHidden = true
                    case .failure:
                        imageView.isHidden = true
                        errorImageView.isHidden = false
                }
            }
        } else {
            imageView.isHidden = true
            errorImageView.isHidden = false
        }
    }
}
