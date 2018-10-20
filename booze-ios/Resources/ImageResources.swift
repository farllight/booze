//
//  ImageResources.swift
//  booze-ios
//
//  Created by Владислав Марков on 19/10/2018.
//  Copyright © 2018 Владислав Марков. All rights reserved.
//

import UIKit

class ImageResources {
    static let shared = ImageResources()
    
    let champagne = UIImage(imageLiteralResourceName: "champagne")
    let profile = UIImage(imageLiteralResourceName: "profile")
    let profileAvatarMock = UIImage(imageLiteralResourceName: "profile_mock")
    let checkbox = UIImage(imageLiteralResourceName: "checkbox")
    
    private init() { 
        
    }
}
