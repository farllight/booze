//
//  String+DateStringToTimeStumpInt.swift
//  booze-ios
//
//  Created by Владислав Марков on 20/10/2018.
//  Copyright © 2018 Владислав Марков. All rights reserved.
//

import Foundation

extension String {
    func toTimeStumpInt() -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        guard let date = dateFormatter.date(from: self) else {
            return 0
        }
        
        return Int(date.timeIntervalSince1970)
    }
}
