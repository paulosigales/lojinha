//
//  UICollectionView+Extensions.swift
//  
//
//  Created by Paulo Sigales on 03/06/23.
//

import UIKit

/**
 A convenience initializer for `UICollectionView` that sets up the collection view with the provided data source, delegate, and cell type.
 
 - Parameters:
    - dataSource: The data source object that provides the data for the collection view.
    - delegate: The delegate object that handles the interaction with the collection view.
    - cell: The cell type to be used in the collection view.
 
 Usage:
 ```
 // Initialize the collection view with a data source, delegate, and cell type
 let collectionView = UICollectionView(dataSource: self, delegate: self, cell: CustomCell.self)
 ```
 
 - Note: This convenience initializer sets the collection view frame to zero and applies a default collection view layout. It also assigns the provided data source and delegate to the collection view, registers the specified cell type, and sets the background color of the collection view to a custom background color.
 */
extension UICollectionView {
    convenience init(
        dataSource: UICollectionViewDataSource,
        delegate: UICollectionViewDelegate,
        cell: UICollectionViewCell.Type
    ) {
        self.init(frame: .zero, collectionViewLayout: UICollectionViewLayout().makeLayout())
        self.dataSource = dataSource
        self.delegate = delegate
        self.translatesAutoresizingMaskIntoConstraints = false
        self.registerCell(type: cell.self)
        self.backgroundColor = UIColor.customBackground
    }
}

/**
 A convenience initializer for `UICollectionView` that sets up the collection view with the provided data source, delegate, and cell type.
 
 - Parameters:
    - dataSource: The data source object that provides the data for the collection view.
    - delegate: The delegate object that handles the interaction with the collection view.
    - cell: The cell type to be used in the collection view.
 
 Usage:
 ```
 // Initialize the collection view with a data source, delegate, and cell type
 let collectionView = UICollectionView(dataSource: self, delegate: self, cell: CustomCell.self)
 ```
 
 - Note: This convenience initializer sets the collection view frame to zero and applies a default collection view layout. It also assigns the provided data source and delegate to the collection view, registers the specified cell type, and sets the background color of the collection view to a custom background color.
 */
extension UICollectionView {
    func registerCell(type: UICollectionViewCell.Type) {
        register(type, forCellWithReuseIdentifier: type.identifier)
    }
}

/**
 A convenience initializer for `UICollectionView` that sets up the collection view with the provided data source, delegate, and cell type.
 
 - Parameters:
    - dataSource: The data source object that provides the data for the collection view.
    - delegate: The delegate object that handles the interaction with the collection view.
    - cell: The cell type to be used in the collection view.
 
 Usage:
 ```
 // Initialize the collection view with a data source, delegate, and cell type
 let collectionView = UICollectionView(dataSource: self, delegate: self, cell: CustomCell.self)
 ```
 
 - Note: This convenience initializer sets the collection view frame to zero and applies a default collection view layout. It also assigns the provided data source and delegate to the collection view, registers the specified cell type, and sets the background color of the collection view to a custom background color.
 */

extension UICollectionView {
    func dequeueCell<T: UICollectionViewCell>(withType type: UICollectionViewCell.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withReuseIdentifier: type.identifier, for: indexPath) as? T
    }
}
