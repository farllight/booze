//
//  ColorResources.swift
//  booze-ios
//
//  Created by Владислав Марков on 19/10/2018.
//  Copyright © 2018 Владислав Марков. All rights reserved.
//

import UIKit

class ColorResources {
    static let shared = ColorResources()
    
    let mainThemeColor = UIColor(hex: "#FF186D6C")
    let authTextFieldColor = UIColor(hex: "#80FFFFFF")
    let cellProfileBackgroundColor = UIColor(hex: "#FFEEEEEE").withAlphaComponent(0.3)
    let cellProfileBorderColor = UIColor(hex: "#1A979797").withAlphaComponent(0.3)
    let blueCheckboxBorderColor = UIColor(hex: "#00A0FF")
    
    private init() { 
        
    }
}
