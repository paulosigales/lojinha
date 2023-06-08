//
//  OrderViewModel.swift
//  
//
//  Created by Paulo Sigales on 06/06/23.
//

import UIKit
import Combine
import Network
import Domain

struct OrderViewModel {
    var product: Product
    var size: Size
    var quantity: Int
    
    init(_ order: Order) {
        self.product = order.product
        self.size = order.size
        self.quantity = order.quantity
        updatePriceTotal()
        updatePriceTotalFormatted()
    }
    
    var priceTotal: Double = 0
    var priceTotalFormatted: String = ""
    
    private var price: Double {
        return self.product.actualPrice.currencyToDouble
    }
    
    private mutating func updatePriceTotal() {
        priceTotal = price * Double(quantity)
    }
    
    private mutating func updatePriceTotalFormatted() {
        priceTotalFormatted = priceTotal.toFormattedCurrency()
    }
    
    mutating func updateQuantity(by amount: Int) {
        let newQuantity = self.quantity + amount
        if newQuantity >= 1 {
            self.quantity = newQuantity
        }
        
        guard let index = CartViewModel.orderList.firstIndex(where: { $0.product == product && $0.size == size }) else {
            return
        }
        
        CartViewModel.orderList[index].quantity = quantity
        
        updatePriceTotal()
        updatePriceTotalFormatted()
        
        CartViewModel.updateCartTotal()
        CartViewModel.orderListSubject.send(CartViewModel.orderList)
    }
}


