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
    
    static func checkInCart(product: Product, size: Size) {
        let isInCart = CartViewModel.orderList.contains { $0.product == product && $0.size == size }
        CartViewModel.orderInCartSubject.send(isInCart)
    }
    
    static func add(product: Product, size: Size, quantity: Int) {
        let order = Order(product: product,
                          size: size,
                          quantity: quantity)
        
        CartViewModel.orderList.append(order)
        CartViewModel.updateCartTotal()
        orderListSubject.send(orderList)
    }

    static func removeOrder(withProduct product: Product, size: Size) {
        guard let index = orderList.firstIndex(where: { $0.product == product && $0.size == size}) else {
            return
        }
        
        orderList.remove(at: index)
        CartViewModel.updateCartTotal()
        orderListSubject.send(orderList)
    }
    
    static func updateCartTotal() {
        var total: Double = 0
        CartViewModel.orderList.forEach { order in
            total += order.product.actualPrice.currencyToDouble * Double(order.quantity)
        }
        
        CartViewModel.cartTotalSubject.send(total)
    }
}
