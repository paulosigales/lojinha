//
//  UITableView+Extensions.swift
//  
//
//  Created by Paulo Sigales on 06/06/23.
//


import UIKit

extension UITableView {
    
    /**
     An extension to `UITableView` that provides a convenient initializer for creating a UITableView with a data source, delegate, and cell type.
     
     The `convenience init(dataSource:delegate:cell:)` initializer allows you to create a UITableView with a specified data source, delegate, and cell type. It also sets some common properties for the table view, such as `translatesAutoresizingMaskIntoConstraints`, background color, and separator style.
     
     - Parameters:
       - dataSource: The UITableViewDataSource object that provides the data for the table view.
       - delegate: The UITableViewDelegate object that handles events and customizes the table view's behavior.
       - cell: The UITableViewCell subclass to be used for displaying cells in the table view.
     
     Usage:
     
     ```
     let tableView = UITableView(
         dataSource: self,
         delegate: self,
         cell: CustomTableViewCell.self
     )
     ```
     
     - Note: The `convenience init(dataSource:delegate:cell:)` initializer sets the provided data source and delegate objects to the table view, registers the cell class using the `registerCell(type:)` method, and configures common properties of the table view such as `translatesAutoresizingMaskIntoConstraints`, background color, and separator style.

     */
    
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
    
    /**
     An extension to `UITableView` that provides a convenient method for registering a cell type.
     
     The `registerCell(type:)` method allows you to register a cell type for use in the table view. It associates the cell type with a reuse identifier using the cell type's identifier property.
     
     - Parameters:
        - type: The UITableViewCell subclass to register.
     
     Usage:
     
     ```
     tableView.registerCell(type: CustomTableViewCell.self)
     ```
     
     - Note: The `registerCell(type:)` method registers the specified cell type with the table view using the `register(_:forCellReuseIdentifier:)` method. It uses the cell type's identifier property as the reuse identifier.
     */
    func registerCell(type: UITableViewCell.Type) {
        register(type, forCellReuseIdentifier: type.identifier)
    }
    
    /**
     An extension to `UITableView` that provides a convenient method for dequeuing a reusable cell of a specific type for a given index path.
     
     The `dequeueCell(withType:for:)` method allows you to dequeue a reusable cell of the specified type from the table view for the provided index path. It returns an optional value of the specified cell type, which can be casted to the desired cell type using the `as?` operator.
     
     - Parameters:
       - type: The UITableViewCell subclass to dequeue.
       - indexPath: The index path specifying the location of the cell in the table view.
     
     - Returns: A cell of the specified type, or `nil` if no such cell is available for reuse.
     
     Usage:
     ```
     let indexPath = IndexPath(row: 0, section: 0)
     let cell = tableView.dequeueCell(withType: CustomTableViewCell.self, for: indexPath)
     ```
     
     - Note: The `dequeueCell(withType:for:)` method dequeues a reusable cell from the table view using the `dequeueReusableCell(withIdentifier:for:)` method, passing in the cell type's identifier and the provided index path. It attempts to cast the dequeued cell to the specified cell type using the `as?` operator. If the cast is successful, it returns the cell as an optional value of the specified type.
     */
    func dequeueCell<T: UITableViewCell>(withType type: UITableViewCell.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: type.identifier, for: indexPath) as? T
    }
    
}

/**
 An extension to `UITableView` that provides a convenient method for dequeuing a reusable cell of a specific type for a given index path.
 
 The `dequeueCell(withType:for:)` method allows you to dequeue a reusable cell of the specified type from the table view for the provided index path. It returns an optional value of the specified cell type, which can be casted to the desired cell type using the `as?` operator.

 - Parameters:
   - type: The UITableViewCell subclass to dequeue.
   - indexPath: The index path specifying the location of the cell in the table view.
 
 - Returns: A cell of the specified type, or `nil` if no such cell is available for reuse.
 
 Usage:
 
 ```swift
 let indexPath = IndexPath(row: 0, section: 0)
 let cell = tableView.dequeueCell(withType: CustomTableViewCell.self, for: indexPath)
 ```
 
 - Note: The `dequeueCell(withType:for:)` method dequeues a reusable cell from the table view using the `dequeueReusableCell(withIdentifier:for:)` method, passing in the cell type's identifier and the provided index path. It attempts to cast the dequeued cell to the specified cell type using the `as?` operator. If the cast is successful, it returns the cell as an optional value of the specified type.
 */
extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

