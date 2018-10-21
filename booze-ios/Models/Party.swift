//
//  Party.swift
//  booze-ios
//
//  Created by Владислав Марков on 20/10/2018.
//  Copyright © 2018 Владислав Марков. All rights reserved.
//

import UIKit

struct Party: Codable {
    var id: Int
    var name: String
    var date: Int
    var users: [User]
    var transactions: [Transaction]?
    
    func toDictionary() -> [String: Any] {
        return [
            "name": name,
            "date": date,
            "users": users.map({ $0.toDictionary() }),
            "tranactions": transactions!.map({ $0.toDictionaryForRequest() })
        ]
    }
    
    func toPartyRequestModel() -> PartyRequestModel {
        return PartyRequestModel(name: name, date: date, users: users.map({ return $0.toContants() }))
    }
    
    static func empty() -> Party {
        return Party(id: 0, name: "", date: 0, users: [], transactions: []) 
    }
}
