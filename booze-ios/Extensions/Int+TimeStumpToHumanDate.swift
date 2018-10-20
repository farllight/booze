//
//  Int+TimeStumpToHumanDate.swift
//  booze-ios
//
//  Created by Владислав Марков on 20/10/2018.
//  Copyright © 2018 Владислав Марков. All rights reserved.
//

import Foundation

extension Int {
    func timeStumpToHumanDate() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self)) 
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        return dateFormatter.string(from: date)
    }
}
