//
//  Product.swift
//  
//
//  Created by Paulo Sigales on 02/06/23.
//

public struct ProductList: Codable, Equatable {
    public var products: [Product] = []
}

extension ProductList {
    public static func fixture(products:[Product] = []) -> Self {
        .init(products: products)
    }
}

public struct Product: Codable, Equatable {
   public let name: String
   public let image: String
   public let onSale: Bool
   public let regularPrice: String
   public let actualPrice: String
   public let sizes: [Size]
}

extension Product {
    public static func fixture(name: String = "",
                        image: String = "",
                        onSale: Bool = false,
                        regularPrice: String = "",
                        actualPrice: String = "",
                        sizes: [Size] = []) -> Self {
        .init(name: name,
              image: image,
              onSale: onSale,
              regularPrice: regularPrice,
              actualPrice: actualPrice,
              sizes: sizes)
    }
}


public struct Size: Codable, Equatable {
    public let available:Bool
    public let size: String
}

extension Size {
    public static func fixture(available: Bool = true, size: String = "") -> Self {
        .init(available: available, size: size)
    }
}

