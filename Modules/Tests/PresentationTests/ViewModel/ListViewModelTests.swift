//
//  ListViewModelTests.swift
//  
//
//  Created by Paulo Sigales on 03/06/23.
//

import XCTest
import Combine
import Domain
import Network

@testable import Presentation

class ListViewModelTests: XCTestCase {
    
    func testNumberOfItemsInSection() {
        let productList = [Product.fixture(), Product.fixture(), Product.fixture()]
        let viewModel = ListViewModel(service: ProductListServiceStub(), productList: productList)
        
        let numberOfItems = viewModel.numberOfItemsInSection()
        
        XCTAssertEqual(numberOfItems, 3)
    }
    
    func testProductViewModelAt() {
        let product1 = Product.fixture(name: "Product 1")
        let product2 = Product.fixture(name: "Product 2")
        let product3 = Product.fixture(name: "Product 3")
        let viewModel = ListViewModel(service: ProductListServiceStub(), productList: [product1, product2, product3])
        
        let productViewModel1 = viewModel.productViewModelAt(0)
        let productViewModel2 = viewModel.productViewModelAt(1)
        let productViewModel3 = viewModel.productViewModelAt(2)
        
        XCTAssertEqual(productViewModel1.product, product1)
        XCTAssertEqual(productViewModel2.product, product2)
        XCTAssertEqual(productViewModel3.product, product3)
    }
    
    func testFetchProductList() {
        let expectation = self.expectation(description: "Product list fetched")
        let product1 = Product.fixture(name: "Product 1")
        let product2 = Product.fixture(name: "Product 2")
        let productList = ProductList.fixture(products: [product1, product2])
        let service = ProductListServiceStub()
        service.result = .success(productList)
        let viewModel = ListViewModel(service: service)
        let onSale = false
        
        let cancellable = viewModel.fetchProductList(onSale: onSale)
            .sink(receiveCompletion: { _ in }) { receivedProducts in
                print("Received products: \(receivedProducts)")
                print("Expected products: \(productList)")
                XCTAssertEqual(receivedProducts, productList.products, "Received products should match the expected productListFixture")
                expectation.fulfill()
            }
        
        waitForExpectations(timeout: 2.0)
        cancellable.cancel()
    }


    
    func testFetchProductListFailure() {
        let expectation = self.expectation(description: "Product list fetch failed")
        let error = ServiceError.badRequest
        let service = ProductListServiceStub()
        service.result = .failure(error)
        let viewModel = ListViewModel(service: service)
        let onSale = true
        
        let cancellable = viewModel.fetchProductList(onSale: onSale)
            .sink(receiveCompletion: { completion in
                if case let .failure(receivedError) = completion {
                    XCTAssertEqual(receivedError , error)
                    expectation.fulfill()
                }
            }, receiveValue: { _ in })
        
        waitForExpectations(timeout: 1.0)
        cancellable.cancel()
    }
}

