//
//  Contact.swift
//  booze-ios
//
//  Created by Владислав Марков on 20/10/2018.
//  Copyright © 2018 Владислав Марков. All rights reserved.
//

import UIKit

struct Contact: Hashable {
    let phone: String
    let name: String?
    let surname: String?
    
    func toUser() -> User {
        return User(id: 0,
                    surname: surname,
                    name: name,
                    parties: [],
                    avatar: "",
                    balance: 0)
//                    phone: phone)
    }
}
