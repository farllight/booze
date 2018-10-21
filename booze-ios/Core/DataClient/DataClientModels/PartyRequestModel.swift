//
//  PartyRequestModel.swift
//  booze-ios
//
//  Created by Владислав Марков on 21/10/2018.
//  Copyright © 2018 Владислав Марков. All rights reserved.
//

import UIKit

struct PartyRequestModel {
    var name: String
    var date: Int
    var contacts: [Contact]
    
    func toDictionary() -> [String: Any] {
        return [
            "name": name,
            "date": date,
            "contacts": contacts.map({ $0.toDictionary() })
        ]
    }
}
