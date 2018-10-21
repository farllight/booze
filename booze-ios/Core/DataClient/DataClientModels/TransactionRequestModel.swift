//
//  TransactionRequestModel.swift
//  booze-ios
//
//  Created by Владислав Марков on 21/10/2018.
//  Copyright © 2018 Владислав Марков. All rights reserved.
//

import UIKit

struct TransactionRequestModel {
    let name: String
    let sum: Int
    let users: [User]
    
    func toDictionary() -> [String: Any] {
        return [
            "name": name,
            "sum": sum,
//
//            users: users.map({ return $0.toDictionary() })
        ]
    }
}
