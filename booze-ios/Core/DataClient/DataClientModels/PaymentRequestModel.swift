//
//  PaymentRequestModel.swift
//  booze-ios
//
//  Created by Владислав Марков on 21/10/2018.
//  Copyright © 2018 Владислав Марков. All rights reserved.
//

import UIKit

struct PaymentRequestModel {
    var amount: Int
    var userId: Int
    var partyId: Int
    var date: Int
    var name: String
    
    func toDictionary() -> [String: Any] {
        return [
            "amount": amount,
            "user": [
                "id": userId
            ],
            "party": [
                "id": partyId
            ],
            "date": date,
            "name": name
        ]
    }
}
