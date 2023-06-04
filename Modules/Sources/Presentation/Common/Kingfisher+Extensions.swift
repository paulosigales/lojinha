//
//  Kingfisher+Extensions.swift
//  
//
//  Created by Paulo Sigales on 03/06/23.
//

import UIKit
import Kingfisher

extension KingfisherManager {
    public func getImage(image:String, imageView: UIImageView, errorImageView: UIView) {
        if let url = URL(string: image) {
            self.retrieveImage(with: url) { result in
                switch result {
                    case .success(let value):
                        imageView.image = value.image
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
