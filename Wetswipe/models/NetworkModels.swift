//
//  NetworkModels.swift
//  Wetswipe
//
//  Created by Adrià Bosch Saez on 21/08/2018.
//  Copyright © 2018 Adrià Bosch Saez. All rights reserved.
//

import Foundation

struct ErrorModel: Codable {
    
    let errorCode: Int
}

struct VoidModel: Codable { }

struct UserCredentials: Codable {
    
    let email: String
    let password: String
}

struct JWTResponse: Codable {
    
    let message: String
    let jwt: String
}

struct CreateProfile: Codable {
    
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

struct UpdateProfile: Codable {
    
    let description: String;
    let currentWork: String;
    let college: String;
    let favoriteSong: String
}

struct User: Codable {
    
    let _id: String
    let age: Int
    let college: String
    let currentWork: String
    let description: String
    let favoriteSong: String
    let lookFor: String
    let maxAge: Int
    let minAge: Int
    let name: String
    let sex: String
    let showInApp: Bool
    let maxDistance: Int
    let photos: [String]
}

struct Discovery: Codable {
    
    let _id: String
    let name: String
    let sex: String
    let age: Int
    let photos: Array<String>
    let description: String?
    let currentWork: String?
    let favoriteSong: String?
    let college: String?
}

struct Match: Codable {
    
    let _id: String
    let chatId: String
    let name: String
    let sex: String
    let age: Int
    let photos: Array<String>
    let description: String?
    let currentWork: String?
    let favoriteSong: String?
    let college: String?
}
