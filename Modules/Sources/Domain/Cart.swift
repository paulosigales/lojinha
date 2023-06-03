//
//  Cart.swift
//  
//
//  Created by Paulo Sigales on 02/06/23.
//

public struct Cart {
    var order: [Order] = []
}

public struct Order: Equatable {
   public var product: Product
   public var size: Size
   public var quantity: Int
    
    public init(product: Product, size: Size, quantity: Int) {
        self.product = product
        self.size = size
        self.quantity = quantity
    }
}

extension Order {
    public static func fixture(product: Product = Product.fixture(), size: Size = Size.fixture(), quantity: Int = 1) -> Self {
        .init(product: product, size: size, quantity: quantity)
    }
}

