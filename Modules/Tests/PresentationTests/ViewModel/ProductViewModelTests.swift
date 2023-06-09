//
//  ProductViewModelTests.swift
//  
//
//  Created by Paulo Sigales on 09/06/23.
//

import XCTest
import Domain
@testable import Presentation

class ProductViewModelTests: XCTestCase {
    
    func testProductName() {
        let product = Product.fixture(name: "Product 1")
        let viewModel = ProductViewModel(product)
        
        let productName = viewModel.name
        
        XCTAssertEqual(productName, "product 1")
    }
    
    func testActualPrice() {
        let product = Product.fixture(actualPrice: "R$ 19,90")
        let viewModel = ProductViewModel(product)
        
        let actualPrice = viewModel.actualPrice
        
        XCTAssertEqual(actualPrice, "R$ 19,90")
    }
    
    func testRegularPrice() {
        let product = Product.fixture(regularPrice: "R$ 29,90")
        let viewModel = ProductViewModel(product)
        
        let regularPrice = viewModel.regularPrice
        
        XCTAssertEqual(regularPrice, "R$ 29,90")
    }
    
    func testRegularPriceStrike() {
        let product = Product.fixture(regularPrice: "R$ 29,90")
        let viewModel = ProductViewModel(product)
        
        let regularPriceStrike = viewModel.regularPriceStrike
        
        XCTAssertEqual(regularPriceStrike.string, "R$ 29,90")
        let attributes = regularPriceStrike.attributes(at: 0, effectiveRange: nil)
        let strikethroughStyle = attributes[NSAttributedString.Key.strikethroughStyle] as? NSNumber
        XCTAssertNotNil(strikethroughStyle)
        XCTAssertTrue(strikethroughStyle?.intValue != 0)
    }
    
    func testImage() {
        let product = Product.fixture(image: "vestido.jpg")
        let viewModel = ProductViewModel(product)
        
        let image = viewModel.image
        
        XCTAssertEqual(image, "vestido.jpg")
    }
    
    func testSizes() {
        let size1 = Size.fixture(available: true, size: "G")
        let size2 = Size.fixture(available: false, size: "M")
        let product = Product.fixture(sizes: [size1, size2])
        let viewModel = ProductViewModel(product)
        
        let sizes = viewModel.sizes
        
        XCTAssertEqual(sizes, [size1, size2])
    }
    
    func testSizeAvailable() {
        let size1 = Size.fixture(available: true, size: "G")
        let size2 = Size.fixture(available: false, size: "M")
        let product = Product.fixture(sizes: [size1, size2])
        let viewModel = ProductViewModel(product)
        
        let size1Available = viewModel.sizeAvailable(size: size1)
        let size2Available = viewModel.sizeAvailable(size: size2)
        
        XCTAssertTrue(size1Available)
        XCTAssertFalse(size2Available)
    }
    
    func testAddToCart() {
        let sizeSelected = Size.fixture(size: "M")
        let product = Product.fixture()
        let viewModel = ProductViewModel(product)
        
        viewModel.addToCart(product: product, size: sizeSelected, quantity: 2)
        
        XCTAssertTrue(true)
    }
}

