//
//  UICollectionView+Extensions.swift
//  
//
//  Created by Paulo Sigales on 03/06/23.
//

import UIKit

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

extension UICollectionView {
    func registerCell(type: UICollectionViewCell.Type) {
        register(type, forCellWithReuseIdentifier: type.identifier)
    }
}

extension UICollectionView {
    func dequeueCell<T: UICollectionViewCell>(withType type: UICollectionViewCell.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withReuseIdentifier: type.identifier, for: indexPath) as? T
    }
}

