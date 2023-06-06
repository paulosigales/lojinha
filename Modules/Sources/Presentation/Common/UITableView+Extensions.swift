//
//  UITableView+Extensions.swift
//  
//
//  Created by Paulo Sigales on 06/06/23.
//


import UIKit

extension UITableView {
    convenience init(dataSource: UITableViewDataSource,
                     delegate: UITableViewDelegate,
                     cell: UITableViewCell.Type
    ) {
        self.init()
        self.dataSource = dataSource
        self.delegate = delegate
        self.translatesAutoresizingMaskIntoConstraints = false
        self.registerCell(type: cell.self)
        self.backgroundColor = UIColor.customBackground
        self.separatorStyle = .none
    }
    
    func registerCell(type: UITableViewCell.Type) {
        register(type, forCellReuseIdentifier: type.identifier)
    }
    
    func dequeueCell<T: UITableViewCell>(withType type: UITableViewCell.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: type.identifier, for: indexPath) as? T
    }
    
}

extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

