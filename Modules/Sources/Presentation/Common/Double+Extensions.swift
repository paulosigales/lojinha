//
//  Double+Extensions.swift
//  
//
//  Created by Paulo Sigales on 06/06/23.
//

import Foundation

/**
 An extension to `Double` that provides a convenient method for formatting a double value as a localized currency string.
 
 The `toFormattedCurrency()` method formats the double value as a localized currency string using the Brazilian Portuguese locale ("pt_BR").
 
 Usage:
 ```
 let price: Double = 19.99
 
 // Format the price as a currency string "R$ 19,99"
 let formattedPrice = price.toFormattedCurrency()
 
 // Use the formatted price for display or further processing
 ...
 ```
 
 - Note: The `toFormattedCurrency()` method uses a `NumberFormatter` to format the double value as a localized currency string. It sets the locale to Brazilian Portuguese ("pt_BR"), the number style to currency, and the maximum fraction digits to 2. It returns the formatted currency string or an empty string if formatting fails.
 */
extension Double {
    func toFormattedCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        
        if let priceFormatted = formatter.string(from: self as NSNumber) {
            return priceFormatted
        }
        
        return ""
    }
}

