//
//  UIActivityIndicator+Extensions
//  
//
//  Created by Paulo Sigales on 03/06/23.
//

import UIKit

extension UIActivityIndicatorView {
    func defaultIndicator() -> Self {
        self.color = UIColor.customSecondary
        self.style = .large
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
}
