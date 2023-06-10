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
    
    /**
     Updates the quantity of the order by the specified amount and performs necessary calculations and updates.
     
     The `updateQuantity(by:)` method adjusts the quantity of the order by adding the specified `amount` to the current quantity. If the resulting quantity is greater than or equal to 1, it updates the `quantity` property with the new value. It then searches for the order in the `CartViewModel.orderList` based on the `product` and `size` properties and updates its quantity to the new value. After updating the order, it calls the necessary methods to recalculate the price total and apply any additional changes. Finally, it updates the cart total in the `CartViewModel` and notifies subscribers about the updated order list using the `CartViewModel.orderListSubject`.
     
     - Parameters:
       - amount: The amount to increment or decrement the quantity by.
     
     - Note: The `CartViewModel.orderList`, `CartViewModel.updateCartTotal()`, and `CartViewModel.orderListSubject` are static properties of the `CartViewModel` struct, accessible globally across the application.
     
     - SeeAlso: `updatePriceTotal()`, `updatePriceTotalFormatted()`, `CartViewModel.updateCartTotal()`, `CartViewModel.orderListSubject`
     */
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


