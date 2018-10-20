//
//  User.swift
//  booze-ios
//
//  Created by Владислав Марков on 20/10/2018.
//  Copyright © 2018 Владислав Марков. All rights reserved.
//

import UIKit

struct User: Codable {  
    var id: Int
    var surname: String?
    var name: String?
    var parties: [Party]
    var avatar: String?
    var balance: Double?
    
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "surname": surname as Any,
            "name": name as Any,
            "parties": parties.map({ $0.toDictionary() }),
            "avatar": avatar as Any,
            "balance": balance as Any
        ]
    }
}
