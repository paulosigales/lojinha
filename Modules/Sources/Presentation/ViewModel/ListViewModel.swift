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
    
    func fetchProductList() -> AnyPublisher<[Product], ServiceError> {
        return Future<[Product], ServiceError> { promise in
            self.service.fetch { result in
                switch result {
                    case .success(let productList):
                        self.productList = productList.products
                        promise(.success(self.productList))
                    case .failure(let error):
                        promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}


