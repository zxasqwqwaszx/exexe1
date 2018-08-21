//
//  User.swift
//  Wetswipe
//
//  Created by Adrià Bosch Saez on 25/02/2018.
//  Copyright © 2018 Adrià Bosch Saez. All rights reserved.
//

import Foundation

class User {
    
    var name: String
    var age:  Int
    var photos: [String]
    
    init(name: String, age: Int, photos: [String]) {
        self.name = name
        self.age = age
        self.photos = photos
    }
    
    struct UserCredentials: Decodable {
        
        let email: String
        
        let password: String
    }
    
    struct JWT: Decodable {
        
        let message: String
        let jwt: String
    }
    
}
