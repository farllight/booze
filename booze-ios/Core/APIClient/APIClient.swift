//
//  APIClient.swift
//  booze-ios
//
//  Created by Владислав Марков on 19/10/2018.
//  Copyright © 2018 Владислав Марков. All rights reserved.
//

import UIKit
import Alamofire

typealias Completion = (Data, Error?) -> Void

class APIClient {
    static let shared = APIClient()
    
    private let baseUrl = "http://beta-secothon.profsoft.online/api/"
    private let authToken = UserSessionTracker.shared.token
    
    private init() {
        
    }
    
    private func baseRequest(path: String, method: HTTPMethod, params: Parameters?, headers: HTTPHeaders, completion: @escaping Completion) {
        Alamofire.request(baseUrl + path, method: method, parameters: params, encoding: JSONEncoding(), headers: headers).responseJSON { (data) in
            
            let statusCode = data.response?.statusCode
            if statusCode == 200 {
                completion(data.data ?? Data(), nil)
            } else if statusCode == 404 {
                completion(Data(), NSError(domain: "Server Error", code: 404, userInfo: nil))
            } else if statusCode == nil {
                completion(Data(), NSError(domain: "Internet Error", code: -1009, userInfo: nil))
            } else {
                completion(Data(), NSError(domain: "Unknown Error", code: statusCode ?? 1, userInfo: nil))
            }
        }
    }

    func registration(phone: String, completion: @escaping Completion) {
        let params = [
            "phone": phone,
            "platform": "iOS",
            "version": "1.0",
            "name": "far__light"
        ]
        baseRequest(path: "registration", method: .post, params: params, headers: ["Content-Type" : "application/json"], completion: completion)
    }
    
    func login(phone: String, password: String, completion: @escaping Completion) {
        let params = [
            "phone": phone,
            "password": password,
            "platform": "iOS",
            "version": "1.0",
            "name": "far__light"
        ]
        baseRequest(path: "login", method: .post, params: params, headers: ["Content-Type" : "application/json"], completion: completion)
    }
    
    func getUser(userId: Int, completion: @escaping Completion) {
        baseRequest(path: "user/\(userId)", method: .get, params: nil, headers: ["apikey": authToken], completion: completion)
    }
    
    func setParty(party: Party, completion: @escaping Completion) {
        baseRequest(path: "party/", method: .post, params: party.toDictionary(), headers: ["Content-Type" : "application/json", "apikey": authToken], completion: completion)
    }
}
