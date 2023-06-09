//
//  OrderViewModelTests.swift
//  
//
//  Created by Paulo Sigales on 09/06/23.
//

import XCTest
import Combine
import Domain
@testable import Presentation

class OrderViewModelTests: XCTestCase {
    
    func testUpdateQuantity_Increment() {
        let order = Order.fixture()
        var viewModel = OrderViewModel(order)
        
        let initialQuantity = viewModel.quantity
        let expectedQuantity = initialQuantity + 1
        
        viewModel.updateQuantity(by: 1)
        
        XCTAssertEqual(viewModel.quantity, expectedQuantity)
    }
    
    func testUpdateQuantity_Decrement() {
        let order = Order.fixture(quantity: 2)
        var viewModel = OrderViewModel(order)
        
        let initialQuantity = viewModel.quantity
        let expectedQuantity = initialQuantity - 1
        
        viewModel.updateQuantity(by: -1)
        
        XCTAssertEqual(viewModel.quantity, expectedQuantity)
    }
    
    func testUpdateQuantity_Decrement_whenOne() {
        let order = Order.fixture(quantity: 1)
        var viewModel = OrderViewModel(order)
        
        let initialQuantity = viewModel.quantity
        let expectedQuantity = initialQuantity
        
        viewModel.updateQuantity(by: -1)
        
        XCTAssertEqual(viewModel.quantity, expectedQuantity)
    }
}

