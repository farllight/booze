//
//  APIClient.swift
//  booze-ios
//
//  Created by Владислав Марков on 19/10/2018.
//  Copyright © 2018 Владислав Марков. All rights reserved.
//

import UIKit
import Alamofire

class APIClient {
    static let shared = APIClient()
    
    private let baseUrl = "http://beta-secothon.profsoft.online/api/"
    
    private init() {
        
    }
    
    func request(url: URLConvertible, method: HTTPMethod, params: Parameters) {
        // TODO: - send request

    }
}
