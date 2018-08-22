//
//  ApiResponse.swift
//  Wetswipe
//
//  Created by Adrià Bosch Saez on 22/08/2018.
//  Copyright © 2018 Adrià Bosch Saez. All rights reserved.
//

import Foundation

class ApiResponse<T> {
    
    let result: Int
    let errorCode: Int
    let content: T?
    
    init(result: Int, errorCode: Int = -1, content: T? = nil) {
        self.result = result
        self.errorCode = errorCode
        self.content = content
    }
    
}
