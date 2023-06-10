//
//  UICollectionViewCell+Extensions.swift
//  
//
//  Created by Paulo Sigales on 03/06/23.
//

import UIKit

/**
 The reuse identifier for the collection view cell.
 
 This property returns a string representation of the cell class name, which is commonly used as the reuse identifier when registering and dequeuing cells in a collection view.
 
 - Note: The reuse identifier is typically set on the cell class itself using the `register(_:forCellWithReuseIdentifier:)` method of the collection view. It should be unique within the collection view.
 
 Usage:
 ```
 // Register the cell with the collection view
 collectionView.register(CustomCell.self, forCellWithReuseIdentifier: CustomCell.identifier)
 
 // Dequeue the cell using the identifier
 let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCell.identifier, for: indexPath) as! CustomCell
 ```
 */
extension UICollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}
