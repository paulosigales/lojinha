//
//  File.swift
//  
//
//  Created by Paulo Sigales on 05/06/23.
//

import Foundation
import UIKit
import Combine
import Network
import Domain

struct CartViewModel {
    
    static var orderList:[Order] = []
    static let orderListSubject = CurrentValueSubject<[Order], Never>(orderList)
    static let orderInCartSubject = CurrentValueSubject<Bool,Never>(false)
    static let cartTotalSubject = CurrentValueSubject<Double, Never>(0.0)
    
    static func orderAtIndex(_ index: Int) -> Order {
        return CartViewModel.orderList[index]
    }
    
    /**
     Checks if an order with the specified product and size exists in the cart, and notifies subscribers.
     
     This function checks if an order with the provided product and size exists in the `orderList` using the `contains` method. It determines whether the product is already present in the cart and assigns the result to the `isInCart` variable. The function then notifies subscribers about the presence of the product in the cart using the `orderInCartSubject`.
     
     The `orderInCartSubject` is a Combine `CurrentValueSubject` that emits a boolean value indicating whether the specified product and size are present in the cart. Subscribers can listen to this subject to receive updates about the presence or absence of the product in the cart.
     
     - Parameters:
       - product: The product to check for in the cart.
       - size: The size of the product to check for in the cart.
     */
    static func checkInCart(product: Product, size: Size) {
        let isInCart = CartViewModel.orderList.contains { $0.product == product && $0.size == size }
        CartViewModel.orderInCartSubject.send(isInCart)
    }
    
    /**
     Adds a new order to the cart and notifies subscribers.
     
     This function creates a new `Order` instance with the provided product, size, and quantity, and appends it to the `orderList` in the cart. It then calls `updateCartTotal()` to recalculate the total price of the cart and notifies subscribers about the updated
     order list using the `orderListSubject`.
     
     - Parameters:
       - product: The product to add to the cart.
       - size: The selected size of the product.
       - quantity: The quantity of the product to add.
     
     The `orderListSubject` is a Combine `CurrentValueSubject` that emits the current array of orders in the cart. Subscribers can listen to this subject to receive updates whenever the order list changes.
     */
    static func add(product: Product, size: Size, quantity: Int) {
        let order = Order(product: product,
                          size: size,
                          quantity: quantity)
        
        CartViewModel.orderList.append(order)
        CartViewModel.updateCartTotal()
        orderListSubject.send(orderList)
    }
    
    /**
     Removes an order from the cart with the specified product and size, and notifies subscribers.
     
     This function searches for an order in the `orderList` with the provided product and size. If a matching order is found, it is removed from the list. The function then calls `updateCartTotal()` to recalculate the total price of the cart and notifies subscribers about the updated order list using the `orderListSubject`.
     
     - Parameters:
        - product: The product of the order to remove.
        - size: The size of the order to remove.
     
     The `orderListSubject` is a Combine `CurrentValueSubject` that emits the current array of orders in the cart. Subscribers can listen to this subject to receive updates whenever the order list changes.
     */
    static func removeOrder(withProduct product: Product, size: Size) {
        guard let index = orderList.firstIndex(where: { $0.product == product && $0.size == size}) else {
            return
        }
        
        orderList.remove(at: index)
        CartViewModel.updateCartTotal()
        orderListSubject.send(orderList)
    }
    
    /**
     Updates the cart's total price and notifies subscribers.
     
     This function calculates the total price of all the orders in the cart by iterating through the `orderList`. It multiplies each order's actual price by its quantity and accumulates the total. Finally, it sends the updated total to the `cartTotalSubject`, notifying any subscribers about the change.
     
     The `cartTotalSubject` is a Combine `CurrentValueSubject` that emits the current total price of the cart. Subscribers can listen to this subject to receive updates whenever the total price changes.
     */
    static func updateCartTotal() {
        var total: Double = 0
        CartViewModel.orderList.forEach { order in
            total += order.product.actualPrice.currencyToDouble * Double(order.quantity)
        }
        
        CartViewModel.cartTotalSubject.send(total)
    }
}
