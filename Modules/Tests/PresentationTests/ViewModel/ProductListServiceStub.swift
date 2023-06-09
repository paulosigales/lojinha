//
//  File.swift
//  
//
//  Created by Paulo Sigales on 09/06/23.
//

import XCTest
import Domain
import Network

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

