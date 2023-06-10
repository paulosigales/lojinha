//
//  UIAlertController+Extensions.swift
//  
//
//  Created by Paulo Sigales on 06/06/23.
//

import UIKit

/**
 An extension to `UIAlertController` that provides a convenient initializer for creating alert controllers with predefined cancel and confirm actions.
 
 The `convenience init(...)` initializer creates an alert controller with a specified title, message, cancel button title, confirm button title, and confirm button action.

 - Parameters:
    - title: The title of the alert controller.
    - message: The message of the alert controller.
    - cancelTitle: The title of the cancel button.
    - confirmTitle: The title of the confirm button.
    - confirmAction: The closure to be executed when the confirm button is tapped.
 
 Usage:
 ```
 // Create an alert controller with cancel and confirm actions
 let alertController = UIAlertController(title: "Confirmation", message: "Are you sure you want to proceed?", cancelTitle: "Cancel", confirmTitle: "Confirm") {
 // Confirm button action
 // Perform action here
 }
 
 // Present the alert controller
 self.present(alertController, animated: true, completion: nil)
 ```

 - Note: The `init(title:message:cancelTitle:confirmTitle:confirmAction:)` initializer creates an alert controller with a cancel action and a destructive (confirm) action. The confirmAction closure is called when the confirm button is tapped.
 */
extension UIAlertController {
    convenience init(title: String,
                     message: String,
                     cancelTitle: String,
                     confirmTitle: String,
                     confirmAction: @escaping () -> Void) {
        
        self.init(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel)
        let confirmAction = UIAlertAction(title: confirmTitle, style: .destructive) { _ in
            confirmAction()
        }
        
        self.addAction(cancelAction)
        self.addAction(confirmAction)
    }
}
