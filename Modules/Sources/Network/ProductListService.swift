//
//  ProductListService.swift
//  
//
//  Created by Paulo Sigales on 02/06/23.
//

import Foundation
import Domain
/**
 The service responsible for fetching the product list.
 
 The `ProductListService` class is responsible for fetching the product list from a specified endpoint. It uses a `ServiceProvider` to make the network request and receives the result through a completion closure.
 */

public protocol ProductListServiceProtocol {
    func fetch(completion: @escaping (Result<ProductList, ServiceError>) -> ())
}

public class ProductListService: ProductListServiceProtocol, ServiceProvider {
    
    private let service: ServiceProvider
    private let endpoint = URL(string: "https://www.mocky.io/v2/59b6a65a0f0000e90471257d")!
    
    public init(service: ServiceProvider = Service()) {
        self.service = service
    }
    
    /**
     Fetches the product list from the specified endpoint.
     
     This method makes a network request to the endpoint URL and expects a response of type `ProductList`. It uses the `service` instance to make the request and delivers the result through the provided completion closure.
     
     - Parameter completion: The closure to be called when the request completes, containing the result of the request as a `Result` type.
     */
//    func fetch(completion: @escaping (Result<ProductList, ServiceError>) -> ()) {
//        service.makeRequest(url: endpoint as URL) { result in
//            completion(result)
//        }
//    }
//
    public func makeRequest<T: Codable>(url: URL, completion: @escaping (Result<T, ServiceError>) -> ()) {
        service.makeRequest(url: url, completion: completion)
    }
    
    public func fetch(completion: @escaping (Result<ProductList, ServiceError>) -> ()) {
        makeRequest(url: endpoint) { (result: Result<ProductList, ServiceError>) in
            completion(result)
        }
    }
}
