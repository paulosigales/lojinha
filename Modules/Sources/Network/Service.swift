//
//  Service.swift
//  
//
//  Created by Paulo Sigales on 02/06/23.
//

import Foundation

/**
 The protocol for a service provider that makes network requests.
 
 The `ServiceProvider` protocol defines the interface for a service provider that can make network requests. It includes a generic method `makeRequest(_:completion:)` for sending requests and receiving responses.
 */
public protocol ServiceProvider {
    func makeRequest<T:Codable>(url: URL, completion: @escaping(Result<T,ServiceError>) -> ())
}

/**
 An enumeration representing possible errors that can occur during network requests.
 
 The `ServiceError` enumeration defines various error cases that can occur during network requests. It conforms to the `Error` and `Equatable` protocols.
 */
public enum ServiceError: Error, Equatable {
    case parseError
    case statusCode(Int)
    case badRequest
}

/**
 A service class that makes network requests using `URLSession`.
 
 The `Service` class implements the `ServiceProvider` protocol and provides the functionality to make network requests using the `URLSession` API. It handles the parsing of response data and delivers the result to the completion closure provided.
 */
public class Service: ServiceProvider {
    
    public init(){}
    
    /**
     Makes a network request to the specified URL.
     
     This method sends a network request to the given URL and expects a response of type `T`. It handles errors, response status codes, and parsing of the response data. It uses the `URLSession` API to perform the network request asynchronously.
     
     - Parameters:
       - url: The URL to send the request to.
       - completion: The closure to be called when the request completes, containing the result of the request as a `Result` type.
     */
    public func makeRequest<T:Codable>(url: URL, completion: @escaping(Result<T,ServiceError>) -> ()) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard error == nil,
                  let response = response as? HTTPURLResponse,
                  let data = data
            else {
                completion(.failure(.badRequest))
                return
            }
            
            do {
                guard response.statusCode == 200 else {
                    completion(.failure(ServiceError.statusCode(response.statusCode)))
                    return
                }
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let result = try decoder.decode(T.self, from: data)
                completion(.success(result))
            }
            catch {
                completion(.failure(.parseError))
            }
            
        }.resume()
    }
    
}
