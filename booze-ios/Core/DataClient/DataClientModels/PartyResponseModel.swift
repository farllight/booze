//
//  PartyResponseModel.swift
//  booze-ios
//
//  Created by Владислав Марков on 23/10/2018.
//  Copyright © 2018 Владислав Марков. All rights reserved.
//

import Foundation

struct PartyResponseModel: Codable {
    var id: Int
    var avatar: String?
    var balance: Double
    var name: String
    var date: Int
    
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "avatar": avatar,
            "balance": balance,
            "name": name,
            "date": date
        ]
    }
}
