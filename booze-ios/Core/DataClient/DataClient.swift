//
//  DataClient.swift
//  booze-ios
//
//  Created by Владислав Марков on 20/10/2018.
//  Copyright © 2018 Владислав Марков. All rights reserved.
//

import UIKit

class DataClient {
    typealias IsSuccessCimpletion = (Bool) -> Void
    
    static let shared = DataClient()
    
    private init() {
        
    }
    
    func registration(phone: String, completion: @escaping IsSuccessCimpletion) {
        APIClient.shared.registration(phone: phone) { (data) in
            completion(true)
        }
    }
    
    func login(phone: String, password: String, completion: @escaping IsSuccessCimpletion) {
        APIClient.shared.login(phone: phone, password: password) { (data) in
            // TODO: - parse response
        }
    }
}
