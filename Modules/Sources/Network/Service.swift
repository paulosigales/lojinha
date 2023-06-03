//
//  Service.swift
//  
//
//  Created by Paulo Sigales on 02/06/23.
//

import Foundation


import Foundation

public protocol ServiceProvider {
    func makeRequest<T:Codable>(url: URL, completion: @escaping(Result<T,ServiceError>) -> ())
}

public enum ServiceError: Error, Equatable {
    case parseError
    case statusCode(Int)
    case badRequest
}

public class Service: ServiceProvider {
    
    public init(){}
    
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


