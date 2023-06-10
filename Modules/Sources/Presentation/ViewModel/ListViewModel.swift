//
//  ListViewModel.swift
//  
//
//  Created by Paulo Sigales on 03/06/23.
//

import Combine
import Network
import Domain

class ListViewModel {
    var service: ProductListServiceProtocol
    var productList: [Product]
    
    init(service: ProductListServiceProtocol = ProductListService(), productList: [Product] = []) {
        self.service = service
        self.productList = productList
    }
    
    func numberOfItemsInSection() -> Int {
        productList.count
    }
    
    func productViewModelAt(_ index: Int) -> ProductViewModel {
        return ProductViewModel(productList[index])
    }
    
    /**
     Fetches the product list from the service.
     
     This method initiates the fetching of the product list from the `ProductListService`. It accepts an `onSale` parameter to specify whether to fetch only products on sale or all products. It returns a publisher that emits either the fetched product list or an error.
     
     - Parameters:
        - onSale: A boolean value indicating whether to fetch only products on sale.
     
     - Returns: A publisher that emits an array of `Product` objects or an error.
     */
    func fetchProductList(onSale: Bool) -> AnyPublisher<[Product], ServiceError> {
        return Future<[Product], ServiceError> { promise in
            self.service.fetch { result in
                switch result {
                    case .success(let productList):
                        self.productList = onSale
                        ? productList.products.filter { $0.onSale == onSale }
                        : productList.products
                        promise(.success(self.productList))
                    case .failure(let error):
                        promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}


