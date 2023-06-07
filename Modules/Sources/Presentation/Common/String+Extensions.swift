//
//  String+Extensions.swift
//  
//
//  Created by Paulo Sigales on 03/06/23.
//

import UIKit

extension String {
    func strikeThrough() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0,attributeString.length))
        return attributeString
    }
}

extension String {
    static let numberFormatter = NumberFormatter()
    
    var currencyToDouble: Double {
        let number = self.replacingOccurrences(of: "R$", with: "")
        String.numberFormatter.decimalSeparator = ","
        
        if let result = String.numberFormatter.number(from: number) {
            return result.doubleValue
        }
        
        return 0
    }
}
