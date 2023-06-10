//
//  String+Extensions.swift
//  
//
//  Created by Paulo Sigales on 03/06/23.
//

import UIKit

/**
 An extension to `String` that provides a convenient method for creating an attributed string with a strikethrough style.
 
 The `strikeThrough()` method creates an `NSAttributedString` with a strikethrough style applied to the entire string.
 
 Usage:
 ```
 let text = "R$ 19,99"
 
 // Create an attributed string with a strikethrough style
 let attributedText = text.strikeThrough()
 
 // Use the attributed text for display or further customization
 ```
 */
extension String {
    func strikeThrough() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0,attributeString.length))
        return attributeString
    }
}

/**
 An extension to `String` that provides a convenient property for converting a currency string to a `Double` value.
 
 The `currencyToDouble` property allows you to convert a currency string, with the format "R$X.XX", to a `Double` value. It removes the "R$" symbol and replaces the decimal separator with a comma (",") before performing the conversion.
 
 Usage:
 ```
 let priceString = "R$19.99"
 
 // Convert the price string to a double value 19.99
 let price = priceString.currencyToDouble
 
 // Use the converted price for calculations or further processing
 ...
 ```
 
 - Note: The `currencyToDouble` property uses a `NumberFormatter` with the decimal separator set to a comma (",") to perform the conversion. It removes the "R$" symbol from the string before converting it to a `Double` value. If the conversion fails, it returns 0.
 */
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
