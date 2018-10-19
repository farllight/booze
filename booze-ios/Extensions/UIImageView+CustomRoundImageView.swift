//
//  UIImageView+CustomRoundImageView.swift
//  booze-ios
//
//  Created by Владислав Марков on 20/10/2018.
//  Copyright © 2018 Владислав Марков. All rights reserved.
//

import UIKit

extension UIImageView {
    func roundImageView() {
        layer.cornerRadius = frame.height / 2
        clipsToBounds = true
    }
}
