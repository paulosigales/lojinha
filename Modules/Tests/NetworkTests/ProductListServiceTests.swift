//
//  ProductListServiceTests.swift
//  
//
//  Created by Paulo Sigales on 02/06/23.
//

import XCTest
import Domain
@testable import Network

class ProductListServiceTests: XCTestCase {
    
    let serviceStub = ProductListServiceStub()
    
    func testFetch_SuccessfulResponse() {
        let size1 = Size.fixture()
        let size2 = Size.fixture()
        let product1 = Product.fixture(sizes: [size1, size2])
        let productList = ProductList.fixture(products: [product1])
        
        serviceStub.result = .success(productList)
        
        let expectation = XCTestExpectation(description: "Fetch completion called")
        
        serviceStub.fetch { result in
            switch result {
            case .success(let fetchedProductList):
                    XCTAssertEqual(fetchedProductList, productList, "Fetched product list should match the expected product list")
            case .failure:
                XCTFail("Unexpected failure")
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }

    
    func testFetch_FailureResponse() {
        serviceStub.result = .failure(.badRequest)
        
        let expectation = XCTestExpectation(description: "Fetch completion called")
        
        serviceStub.fetch { result in
            switch result {
            case .success:
                XCTFail("Unexpected success")
            case .failure(let error):
                XCTAssertEqual(error, .badRequest, "Received error should match the expected error")
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
}
