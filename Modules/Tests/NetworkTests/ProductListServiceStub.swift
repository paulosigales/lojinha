//
//  ProductListServiceStub.swift
//  
//
//  Created by Paulo Sigales on 02/06/23.
//

import XCTest
import Domain
@testable import Network

public class ProductListServiceStub: ProductListServiceProtocol {
    var result: Result<ProductList, ServiceError>?
    
    public func fetch(completion: @escaping (Result<ProductList, ServiceError>) -> ()) {
        DispatchQueue.main.async {
            if let result = self.result {
                completion(result)
            }
        }
    }
}
