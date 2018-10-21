//
//  Transaction.swift
//  booze-ios
//
//  Created by Владислав Марков on 21/10/2018.
//  Copyright © 2018 Владислав Марков. All rights reserved.
//

import UIKit

struct Transaction: Codable {
    var user: User?
    var id: Int
    var amount: Int
    var targetUser: User?
    var date: Int
    var name: String
    var type: String
    var avatar: String?
//    var users: [User]
    
    func toDictionaryForRequest() -> [String: Any] {
        return [
            "name": name,
            "date": date,
            "users": [
                user!.toDictionary(),
                targetUser!.toDictionary()
            ],
        ]
    }
}
