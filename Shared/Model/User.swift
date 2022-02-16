//
//  User.swift
//  Artable
//
//  Created by Hamza on 2/9/22.
//  Copyright © 2022 Hamza. All rights reserved.
//

import Foundation

struct User {
    var id: String
    var email: String
    var username: String
    
    
    init(id: String = "", email: String = "", username: String = "") {
        self.id = id
        self.email = email
        self.username = username
    }
    
    init(data: [String: Any]) {
        id = data["id"] as? String ?? ""
        email = data["email"] as? String ?? ""
        username = data["username"] as? String ?? ""
    }
    
    static func modelToData(user: User) -> [String: Any] {
        let data : [String: Any] = [
            "id": user.id,
            "email": user.email,
            "username": user.username
        ]
        
        return data
    }
    
    
}
