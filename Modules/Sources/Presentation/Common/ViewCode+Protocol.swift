//
//  ViewCode+Protocol.swift
//  
//
//  Created by Paulo Sigales on 03/06/23.
//

/**
 A protocol `ViewCode` that defines a set of methods for implementing the View Code pattern in a `UIViewController`.
 
 The `ViewCode` protocol includes the following methods:
 - `buildHierarchy()`: Defines the view hierarchy by adding subviews to the view controller's `view`.
 - `setupConstraints()`: Sets up Auto Layout constraints for the view controller's `view` and its subviews.
 - `applyAdditionalChanges()`: Performs any additional configuration or customization for the view controller's `view`.
 
 By conforming to the `ViewCode` protocol, a `UIViewController` subclass can implement these methods to separate the view configuration logic into smaller, more manageable parts.
 
 Usage:
 
 ```
 class MyViewController: UIViewController, ViewCode {
     override func viewDidLoad() {
         super.viewDidLoad()
         setupViewCode()
     }
     
     // Implement the View Code methods
     func buildHierarchy() {
         // Add subviews to the view controller's view
     }
     
     func setupConstraints() {
         // Set up Auto Layout constraints
     }
     
     func applyAdditionalChanges() {
         // Perform additional configuration or customization
     }
     
     // Implement any other custom methods or properties
 }
 ```
 
 - Note: The `setupViewCode()` method provides a convenient way to call the `buildHierarchy()`, `setupConstraints()`, and `applyAdditionalChanges()` methods in a sequential manner. The `buildHierarchy()` and `setupConstraints()` methods are left empty by default, allowing subclasses to override and implement these methods as needed.
 */
protocol ViewCode {
    func buildHierarchy()
    func setupConstraints()
    func applyAdditionalChanges()
}

extension ViewCode {
    func setupViewCode() {
        buildHierarchy()
        setupConstraints()
        applyAdditionalChanges()
    }
    
    func buildHierarchy() {}
    func setupConstraints() {}
    func applyAdditionalChanges() {}
}


