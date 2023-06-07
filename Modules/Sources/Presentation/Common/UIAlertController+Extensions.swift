//
//  UIAlertController+Extensions.swift
//  
//
//  Created by Paulo Sigales on 06/06/23.
//

import UIKit

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
