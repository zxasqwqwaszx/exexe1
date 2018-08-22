//
//  NetworkModels.swift
//  Wetswipe
//
//  Created by Adrià Bosch Saez on 21/08/2018.
//  Copyright © 2018 Adrià Bosch Saez. All rights reserved.
//

import Foundation

struct UserCredentials: Codable {
    
    let email: String
    
    let password: String
}

struct JWTResponse: Decodable {
    
    let message: String
    let jwt: String
}

struct ErrorModel: Decodable {
    
    let errorCode: Int
}
