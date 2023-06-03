//
//  ProductTests.swift
//  
//
//  Created by Paulo Sigales on 02/06/23.
//

import XCTest

@testable import Domain

class ProductTests: XCTestCase {
    
    func testProductEquality() {
        let size1 = Size.fixture(available: false, size: "P")
        let size2 = Size.fixture(available: true, size: "G")
        let product1 = Product.fixture(onSale: true, sizes: [size1,size2])
        let product2 = Product.fixture(onSale: true, sizes: [size1, size2])
        let product3 = Product.fixture(onSale: false, sizes: [size1, size2])

        XCTAssertEqual(product1, product2, "Products should be equal")
        XCTAssertNotEqual(product1, product3, "Products should not be equal")
    }
}

class SizeTests: XCTestCase {
    
    func testSizeEquality() {
        let size1 = Size.fixture(available: true, size: "G")
        let size2 = Size.fixture(available: true, size: "G")
        let size3 = Size.fixture(available: false, size: "M")
        
        XCTAssertEqual(size1, size2, "Sizes should be equal")
        XCTAssertNotEqual(size1, size3, "Sizes should not be equal")
    }
}

class ProductListTests: XCTestCase {
    
    func testProductListInitialization() {
        let product1 = Product.fixture()
        let productList = ProductList(products: [product1])
        
        XCTAssertNotNil(productList, "ProductList should be initialized")
        XCTAssertEqual(productList.products.count, 1, "ProductList should contain 1 product")
        XCTAssertTrue(productList.products.contains(product1), "ProductList should contain product1")
    }
}





