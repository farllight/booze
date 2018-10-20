//
//  APIClient.swift
//  booze-ios
//
//  Created by Владислав Марков on 19/10/2018.
//  Copyright © 2018 Владислав Марков. All rights reserved.
//

import UIKit
import Alamofire

typealias Completion = (Data) -> Void

class APIClient {
    static let shared = APIClient()
    
    private let baseUrl = "http://beta-secothon.profsoft.online/api/"
    private let header = ["Content-Type" : "application/json"]
    
    private init() {
        
    }

    func registration(phone: String, completion: @escaping Completion) {
        let fullUrl = baseUrl + "registration"
        let params = [
            "phone": phone,
            "password": "1",
            "platform": "iOS",
            "version": "1.0",
            "name": "far__light"
        ]
        
        Alamofire.request(fullUrl, method: .post, parameters: params, encoding: JSONEncoding(), headers: header).responseJSON { (data) in
            completion(data.data ?? Data())
        }
    }
    
    func login(phone: String, password: String, completion: @escaping Completion) {
        let fullUrl = baseUrl + "login"
        let params = [
            "phone": phone,
            "password": password,
            "platform": "iOS",
            "version": "1.0",
            "name": "far__light"
        ]
        
        Alamofire.request(fullUrl, method: .post, parameters: params, encoding: JSONEncoding(), headers: header).responseJSON { (data) in
            completion(data.data ?? Data())
        }
    }
}
