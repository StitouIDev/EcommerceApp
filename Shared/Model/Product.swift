//
//  Product.swift
//  Artable
//
//  Created by Hamza on 2/3/22.
//  Copyright © 2022 Hamza. All rights reserved.
//

import Foundation
import FirebaseFirestore


struct Product {
    var name: String
    var id: String     // Firestore ID
    var category: String
    var price: Double
    var productDescription: String
    var imageUrl: String
    var timeStamp: Timestamp
    
    
    init(name: String, id: String, category: String, price: Double, productDescription: String, imageUrl: String, timeStamp: Timestamp = Timestamp()) {
        self.name = name
        self.id = id
        self.category = category
        self.price = price
        self.productDescription = productDescription
        self.imageUrl = imageUrl
        self.timeStamp = timeStamp
    }
    
    init(data: [String: Any]) {
        name = data["name"] as? String ?? ""
        id = data["id"] as? String ?? ""
        category = data["category"] as? String ?? ""
        productDescription = data["productDescription"] as? String ?? ""
        price = data["price"] as? Double ?? 0.0
        imageUrl = data["imageUrl"] as? String ?? ""
        timeStamp = data["timeStamp"] as? Timestamp ?? Timestamp()
    }
    
    static func modelToData(product: Product) -> [String: Any] {
        let data : [String: Any] = [
            "name": product.name,
            "id": product.id,
            "category": product.category,
            "price": product.price,
            "productDescription": product.productDescription,
            "imageUrl": product.imageUrl,
            "timeStamp": product.timeStamp
        ]
        
        return data
    }
}


extension Product : Equatable {
    
    static func ==(lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id
    }
}
