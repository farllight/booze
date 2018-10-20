//
//  Party.swift
//  booze-ios
//
//  Created by Владислав Марков on 20/10/2018.
//  Copyright © 2018 Владислав Марков. All rights reserved.
//

import UIKit

struct Party: Codable {
    let name: String
    let date: Int
    let users: [User]
}
