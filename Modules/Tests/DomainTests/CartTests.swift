//
//  CartTests.swift
//  
//
//  Created by Paulo Sigales on 02/06/23.
//

import XCTest

@testable import Domain

class CartTests: XCTestCase {
    
    func test_CartInitialization() {
        let size = Size.fixture()
        let product = Product.fixture(sizes: [size])
        let order = Order(product: product, size: size, quantity: 2)
        let cart = Cart(order: [order])
        
        XCTAssertTrue(cart.order.contains(order), "Cart should contain the order")
        XCTAssertEqual(cart.order.count, 1, "Cart should have 1 order")
        XCTAssertEqual(cart.order.first?.quantity, 2, "Order quantity should be 2")
        XCTAssertEqual(cart.order.first?.product, product, "Order should contain the expected product")
        XCTAssertEqual(cart.order.first?.size, size, "Order should contain the expected size")
    }
}


class OrderTests: XCTestCase {
    
    func testOrderInitialization() {
        let size = Size.fixture()
        let product = Product.fixture()
        
        let order = Order.fixture(quantity: 2)
        
        XCTAssertEqual(order.product, product, "Order product should be equal to the provided product")
        XCTAssertEqual(order.size, size, "Order size should be equal to the provided size")
        XCTAssertEqual(order.quantity, 2, "Order quantity should be equal to the provided quantity")
    }
}

