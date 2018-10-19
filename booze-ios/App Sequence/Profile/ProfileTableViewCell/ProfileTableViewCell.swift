//
//  ProfileTableViewCell.swift
//  booze-ios
//
//  Created by Владислав Марков on 20/10/2018.
//  Copyright © 2018 Владислав Марков. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    static let xibName = "ProfileTableViewCell"
    static let reuseId = "ProfileTableViewCellReuseId"

    @IBOutlet weak var ibNameLabel: UILabel!
    @IBOutlet weak var ibAdditionalImformationLabel: UILabel!
    
    func setupUI(model: ProfileTableViewCellModel) {
        ibNameLabel.text = model.name
        ibAdditionalImformationLabel.text = model.additionalInformation
    }
}
