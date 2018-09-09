//
//  WetswipeApi.swift
//  Wetswipe
//
//  Created by Adrià Bosch Saez on 06/09/2018.
//  Copyright © 2018 Adrià Bosch Saez. All rights reserved.
//

import Foundation


import Foundation

class WetswipeApi {
    
    let baseUrl = "http://mdpa-adria.azurewebsites.net/" //"http://localhost:3000"
    
    private let jsonEncoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private var jwt: String? = nil
    
    static let instance = WetswipeApi()
    
    func loginUser(_ email: String, _ password: String, _ path: String = "/login", completion: @escaping (ApiResponse<Void>) -> ()) {
        
        let userCredentials = UserCredentials(email: email, password: password)
        let jsonData = try! jsonEncoder.encode(userCredentials)
        
        let url: URL = URL(string: baseUrl + path)!
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
            
            do {
                if let httpStatus = response as? HTTPURLResponse {
                    print("StatusCode = \(httpStatus.statusCode)")
                    
                    if (httpStatus.statusCode == 400) {
                        
                        let errorModel = try self.decoder.decode(ErrorModel.self, from: data)
                        print("ErrorCode = \(errorModel.errorCode)")
                        completion(ApiResponse(result: ApiResult.ERROR, errorCode: errorModel.errorCode))
                    }
                    else if (httpStatus.statusCode > 400) {
                        completion(ApiResponse(result: ApiResult.ERROR))
                    }
                    else {
                        let jwtResponse = try self.decoder.decode(JWTResponse.self, from: data)
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
    
    func executeRequest<T: Codable>(_ request: URLRequest,_ completion: @escaping (ApiResponse<T>) -> ()) {
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error -> Void in
            
            guard let data = data, error == nil else {
                print("Resquest FAILED")
                completion(ApiResponse(result: ApiResult.FAILED))
                return
            }
            
            do {
                if let httpStatus = response as? HTTPURLResponse {
                    print("StatusCode = \(httpStatus.statusCode)")
                    
                    if (httpStatus.statusCode == 400) {
                        
                        let errorModel = try self.decoder.decode(ErrorModel.self, from: data)
                        print("ErrorCode = \(errorModel.errorCode)")
                        completion(ApiResponse(result: ApiResult.ERROR, errorCode: errorModel.errorCode))
                    }
                    else if (httpStatus.statusCode > 400) {
                        completion(ApiResponse(result: ApiResult.ERROR))
                    }
                    else {
                        let responseObject = try self.decoder.decode(T.self, from: data)
                        completion(ApiResponse(result: ApiResult.SUCCESS, content: responseObject))
                    }
                }
            } catch let error {
                print(error.localizedDescription)
                completion(ApiResponse(result: ApiResult.ERROR))
            }
        }
        
        task.resume()
    }
    
    func createProfile<T: Codable>(_ userProfile: T, completion: @escaping (ApiResponse<T>) -> ()) {
        
        let jsonData = try! jsonEncoder.encode(userProfile)
        
        let url: URL = URL(string: baseUrl + "/profile")!
        var request: URLRequest = URLRequest(url: url)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(jwt!)",
            forHTTPHeaderField: "Authorization")
        request.httpMethod = "PATCH"
        request.httpBody = jsonData
        request.timeoutInterval = 20
        request.httpShouldHandleCookies = false
        
        executeRequest(request, completion)
    }
    
    func discoveryUsers(completion: @escaping (ApiResponse<[Discovery]>) -> ()) {
        
        let url: URL = URL(string: baseUrl + "/discovery")!
        var request: URLRequest = URLRequest(url: url)
        
        request.setValue("Bearer \(jwt!)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        request.timeoutInterval = 20
        request.httpShouldHandleCookies = false
        
        executeRequest(request, completion)
    }
    
    func setLike(dicoveryId: String, state: String, completion: @escaping (ApiResponse<VoidModel>) -> ()) {

        let url: URL = URL(string: baseUrl + "/discovery/" + dicoveryId)!
        var request: URLRequest = URLRequest(url: url)
        
        request.setValue("Bearer \(jwt!)", forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let bodyData = "state=" + state
        request.httpBody = bodyData.data(using: String.Encoding.utf8)
        request.timeoutInterval = 20
        request.httpShouldHandleCookies = false
        
        executeRequest(request, completion)
    }
    
    func getMatches(completion: @escaping (ApiResponse<[Match]>) -> ()) {
        
        let url: URL = URL(string: baseUrl + "/match/all")!
        var request: URLRequest = URLRequest(url: url)
        
        request.setValue("Bearer \(jwt!)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        request.timeoutInterval = 20
        request.httpShouldHandleCookies = false
        
        executeRequest(request, completion)
    }
    
    func getUser(completion: @escaping (ApiResponse<User>) -> ()) {
        
        let url: URL = URL(string: baseUrl + "/profile")!
        var request: URLRequest = URLRequest(url: url)
        
        request.setValue("Bearer \(jwt!)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        request.timeoutInterval = 20
        request.httpShouldHandleCookies = false
        
        executeRequest(request, completion)
    }
    
    func updateProfile(_ updateProfile: UpdateProfile, completion: @escaping (ApiResponse<UpdateProfile>) -> ()) {
        
        let jsonData = try! jsonEncoder.encode(updateProfile)
        
        let url: URL = URL(string: baseUrl + "/profile")!
        var request: URLRequest = URLRequest(url: url)
        
        request.setValue("Bearer \(jwt!)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "PATCH"
        request.httpBody = jsonData
        request.timeoutInterval = 20
        request.httpShouldHandleCookies = false
        
        executeRequest(request, completion)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
