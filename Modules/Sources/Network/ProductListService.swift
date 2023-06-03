//
//  ProductListService.swift
//  
//
//  Created by Paulo Sigales on 02/06/23.
//

import Foundation
import Domain

public protocol ProductListServiceProtocol {
    func fetch(completion: @escaping (Result<ProductList, ServiceError>) -> ())
}

public class ProductListService: ProductListServiceProtocol, ServiceProvider {
    
    private let service: ServiceProvider
    private let endpoint = URL(string: "https://www.mocky.io/v2/59b6a65a0f0000e90471257d")!
    
    public init(service: ServiceProvider = Service()) {
        self.service = service
    }
    
    public func makeRequest<T: Codable>(url: URL, completion: @escaping (Result<T, ServiceError>) -> ()) {
        service.makeRequest(url: url, completion: completion)
    }
    
    public func fetch(completion: @escaping (Result<ProductList, ServiceError>) -> ()) {
        makeRequest(url: endpoint) { (result: Result<ProductList, ServiceError>) in
            completion(result)
        }
    }
}
