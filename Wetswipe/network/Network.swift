//
//  Network.swift
//  Wetswipe
//
//  Created by Adrià Bosch Saez on 22/08/2018.
//  Copyright © 2018 Adrià Bosch Saez. All rights reserved.
//

import Foundation

class Network {
    
    let baseUrl = "http://mdpa-adria.azurewebsites.net/"
    
    var jwt: String? = nil
    
    static let instance = Network()
    
    func registerUser(_ email: String, _ password: String, completion: @escaping (ApiResponse<Void>) -> ()) {
        
        let userCredentials = UserCredentials(email: email, password: password)
        let jsonEncoder = JSONEncoder()
        let jsonData = try! jsonEncoder.encode(userCredentials)
        
        let url: URL = URL(string: baseUrl + "/login/register")!
        var request: URLRequest = URLRequest(url: url)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.timeoutInterval = 20
        request.httpShouldHandleCookies = false
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error -> Void in
            
            guard let data = data, error == nil else {
                print("Resquest FAILED")
                completion(ApiResponse(result: ApiResult.FAILED))
                return
            }
           
            let decoder = JSONDecoder()
            
            do {
                if let httpStatus = response as? HTTPURLResponse {
                    print("StatusCode = \(httpStatus.statusCode)")
                    
                    if (httpStatus.statusCode == 400) {
            
                        let errorModel = try decoder.decode(ErrorModel.self, from: data)
                        print("ErrorCode = \(errorModel.errorCode)")
                        completion(ApiResponse(result: ApiResult.ERROR, errorCode: errorModel.errorCode))
                    }
                    else if (httpStatus.statusCode > 400) {
                        completion(ApiResponse(result: ApiResult.ERROR))
                    }
                    else {
                        let jwtResponse = try decoder.decode(JWTResponse.self, from: data)
                        print(jwtResponse.message)
                        self.jwt = jwtResponse.jwt
                        completion(ApiResponse(result: ApiResult.SUCCESS))
                    }
                }
            } catch let error {
                print(error.localizedDescription)
                completion(ApiResponse(result: ApiResult.ERROR))
            }
        }
        
        task.resume()
    }

}

/*let responseString = String(data: data, encoding: .utf8)
 print("responseString = \(responseString)")*/

/*func registerUser(email: String, password: String) {
 
 let url: URL = URL(string: "http://mdpa-adria.azurewebsites.net/login/register")!
 var request: URLRequest = URLRequest(url: url)
 
 request.setValue("application/json", forHTTPHeaderField: "Content-Type")
 request.httpMethod = "POST"
 
 let userCredentials = UserCredentials(email: email, password: password)
 let jsonEncoder = JSONEncoder()
 let jsonData = try! jsonEncoder.encode(userCredentials)
 //let json = String(data: jsonData, encoding: String.Encoding.utf16)
 
 request.httpBody = jsonData
 
 request.timeoutInterval = 60
 request.httpShouldHandleCookies = false
 
 let task = URLSession.shared.dataTask(with: request) { data, response, error in
 guard let data = data, error == nil else {
 print("error=\(error)")
 return
 }
 
 self.dismiss(animated: true, completion: nil)
 
 if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
 print("statusCode should be 200, but is \(httpStatus.statusCode)")
 print("response = \(response)")
 }
 
 /*let responseString = String(data: data, encoding: .utf8)
 print("responseString = \(responseString)")*/
 
 do {
 let decoder = JSONDecoder()
 let response = try decoder.decode(JWTResponse.self, from: data)
 print(response.message)
 print(response.jwt)
 
 } catch let err {
 print("Err", err)
 }
 }
 showLoadingAlert()
 task.resume()
 }*/



















