//
//  NetworkModels.swift
//  Wetswipe
//
//  Created by Adrià Bosch Saez on 21/08/2018.
//  Copyright © 2018 Adrià Bosch Saez. All rights reserved.
//

import Foundation

struct ErrorModel: Decodable {
    
    let errorCode: Int
}

struct UserCredentials: Codable {
    
    let email: String
    let password: String
}

struct JWTResponse: Decodable {
    
    let message: String
    let jwt: String
}

struct UserProfile: Codable {
    
    let name: String
    let age: Int
    let sex: String
    let lookFor: String
    
    let minAge: Int
    let maxAge: Int

    let description: String;
    let currentWork: String;
    let college: String;
    let favoriteSong: String

}
