//
//  Category.swift
//  Artable
//
//  Created by Hamza on 2/3/22.
//  Copyright © 2022 Hamza. All rights reserved.
//

import Foundation
import FirebaseFirestore


struct Category {
    var name: String
    var id: String      // Firestore ID
    var imgUrl: String
    var isActive: Bool = true
    var timeStamp: Timestamp
    
    
    init(name: String, id: String, imgUrl: String,isActive:Bool, timeStamp: Timestamp) {
        self.name = name
        self.id = id
        self.imgUrl = imgUrl
        self.isActive = isActive
        self.timeStamp = timeStamp
    }
    
    
    init(data: [String: Any]) {
        name = data["name"] as? String ?? ""
        id = data["id"] as? String ?? ""
        imgUrl = data["imgUrl"] as? String ?? ""
        isActive = data["isActive"] as? Bool ?? true
        timeStamp = data["timeStamp"] as? Timestamp ?? Timestamp()
    }
    
    static func modelToData(category: Category) -> [String: Any] {
        let data : [String: Any] = [
            "name": category.name,
            "id": category.id,
            "imgUrl": category.imgUrl,
            "isActive": category.isActive,
            "timeStamp": category.timeStamp
            ]
        
        return data
    }
    
    
}
