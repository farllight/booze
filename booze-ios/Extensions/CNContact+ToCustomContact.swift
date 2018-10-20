//
//  CNContact+ToCustomContact.swift
//  booze-ios
//
//  Created by Владислав Марков on 20/10/2018.
//  Copyright © 2018 Владислав Марков. All rights reserved.
//

import Foundation
import ContactsUI

extension CNContact {
    func toCustomContact() -> Contact {
        return Contact(phone: phoneNumbers[0].value.stringValue,
                       name: givenName,
                       surname: familyName)
    }
}
