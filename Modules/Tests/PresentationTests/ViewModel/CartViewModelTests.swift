//
//  CartViewModelTests.swift
//  
//
//  Created by Paulo Sigales on 09/06/23.
//

import XCTest
import Combine
import Domain
@testable import Presentation

class CartViewModelTests: XCTestCase {
    
    func testAddOrder() {
        CartViewModel.orderList = []
        let product = Product.fixture(name: "Product 1")
        let size = Size.fixture()
        let quantity = 2
        let initialOrderListCount = CartViewModel.orderList.count
        
        
        CartViewModel.add(product: product, size: size, quantity: quantity)
        
        XCTAssertEqual(CartViewModel.orderList.count, initialOrderListCount + 1)
        XCTAssertEqual(CartViewModel.orderList.last?.product, product)
        XCTAssertEqual(CartViewModel.orderList.last?.size, size)
        XCTAssertEqual(CartViewModel.orderList.last?.quantity, quantity)
    }
    
    func testUpdateCartTotal() {
        CartViewModel.orderList = []
        let product1 = Product.fixture(name: "Product 1", actualPrice: "10.90")
        let product2 = Product.fixture(name: "Product 2", actualPrice: "19.90")
        let size = Size.fixture()
        let quantity = 2
        
        CartViewModel.add(product: product1, size: size, quantity: quantity)
        CartViewModel.add(product: product2, size: size, quantity: quantity)
        
        CartViewModel.updateCartTotal()
        
        let expectedTotal = (product1.actualPrice.currencyToDouble * Double(quantity)) + (product2.actualPrice.currencyToDouble * Double(quantity))
        XCTAssertEqual(CartViewModel.cartTotalSubject.value, expectedTotal)
    }
    
    func testCheckInCart() {
        CartViewModel.orderList = []
        let product = Product.fixture(name: "Product 1")
        let size = Size.fixture()
        
        CartViewModel.add(product: product, size: size, quantity: 1)
        
        CartViewModel.checkInCart(product: product, size: size)
        
        XCTAssertTrue(CartViewModel.orderInCartSubject.value)
    }
    
    func testRemoveOrder() {
        CartViewModel.orderList = []
        let product = Product.fixture(name: "Product 1")
        let size = Size.fixture()
        
        CartViewModel.add(product: product, size: size, quantity: 1)
        let initialOrderListCount = CartViewModel.orderList.count

        CartViewModel.removeOrder(withProduct: product, size: size)

        XCTAssertEqual(CartViewModel.orderList.count, initialOrderListCount - 1)
        XCTAssertNil(CartViewModel.orderList.first { $0.product == product && $0.size == size })
    }
}
