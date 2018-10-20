//
//  RegistrationResponseModel.swift
//  booze-ios
//
//  Created by Владислав Марков on 20/10/2018.
//  Copyright © 2018 Владислав Марков. All rights reserved.
//

import UIKit

struct RegistrationResponseModel: Codable {
    var user: User
    var version: String
    var token: String
    var platform: String
}
