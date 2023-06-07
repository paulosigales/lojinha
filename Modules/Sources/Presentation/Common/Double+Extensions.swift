//
//  Double+Extensions.swift
//  
//
//  Created by Paulo Sigales on 06/06/23.
//

import Foundation

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
