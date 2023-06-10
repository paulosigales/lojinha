//
//  UICollectionViewLayout+Extensions.swift
//  
//
//  Created by Paulo Sigales on 03/06/23.
//

import UIKit

/**
   Creates a UICollectionViewLayout instance with a specific layout configuration.
   
   This method generates a compositional layout for a collection view with a predefined layout structure. It uses a fractionally-sized item within a group to create a grid-like layout with two items per row.
   
   - Returns: A UICollectionViewLayout instance configured with the compositional layout.
   
   Usage:
   ```
   let layout = UICollectionViewLayout().makeLayout()
   collectionView.collectionViewLayout = layout
   ```
   
   - Note: You can customize the layout structure by modifying the item size, content insets, group size, and other layout properties within the closure passed to the `UICollectionViewCompositionalLayout` initializer.
 */
extension UICollectionViewLayout {
    func makeLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (_, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalWidth(0.7))
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
            
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
        
        return layout
    }
}

