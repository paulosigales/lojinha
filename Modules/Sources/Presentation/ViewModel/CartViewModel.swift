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
    
    static var orderList:[Order] = [] //1
    static let orderListSubject = CurrentValueSubject<[Order], Never>(orderList) //1
    static let orderInCartSubject = CurrentValueSubject<Bool,Never>(false) //1
    
    
    static func orderAtIndex(_ index: Int) -> Order { //1
        return CartViewModel.orderList[index]
    }
    
    static func checkInCart(product: Product, size: Size) { //1
        let isInCart = CartViewModel.orderList.contains { $0.product == product && $0.size == size }
        CartViewModel.orderInCartSubject.send(isInCart)
    }
    
    static func add(product: Product, size: Size, quantity: Int) { //1
        let order = Order(product: product,
                          size: size,
                          quantity: quantity)
        
        CartViewModel.orderList.append(order)
        orderListSubject.send(orderList)
    }
}
