//
//  User.swift
//  booze-ios
//
//  Created by Владислав Марков on 20/10/2018.
//  Copyright © 2018 Владислав Марков. All rights reserved.
//

import UIKit

struct User: Codable {
    var wasted: Int
    var id: Int
    var surname: String?
    var name: String?
    var parties: [Party]?
    var avatar: String?
    var balance: Double
    var phone: String
    var transactions: [Transaction]?
    
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "surname": surname as Any,
            "name": name! as Any,
            "parties": parties!.map({ $0.toDictionary() }),
            "avatar": avatar as Any,
            "balance": balance as Any
        ]
    }
    
    func toContants() -> Contact {
        return Contact(phone: phone, name: name, surname: surname)
    }
    
    func fullName() -> String {
        return "\(name ?? "") \(surname ?? "")"
    }
    
    static func empty() -> User {
        return User(wasted: 0, id: 0, surname: "", name: "", parties: [], avatar: "", balance: 0, phone: "", transactions: [])
    }
}
