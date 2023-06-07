//
//  OrderViewModel.swift
//  
//
//  Created by Paulo Sigales on 06/06/23.
//

import UIKit
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
    }

    private var price: Double {
        return self.product.actualPrice.currencyToDouble
    }
}

