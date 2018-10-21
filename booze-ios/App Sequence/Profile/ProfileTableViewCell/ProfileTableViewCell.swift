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
    @IBOutlet weak var ibSumLabel: UILabel!
    @IBOutlet weak var ibTopBorderView: UIView!
    @IBOutlet weak var ibBottomBorderView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = ColorResources.shared.cellProfileBackgroundColor
        ibTopBorderView.backgroundColor = ColorResources.shared.cellProfileBorderColor
        ibBottomBorderView.backgroundColor = ColorResources.shared.cellProfileBorderColor
    }
    
    func setup(model: ProfileTableViewCellModel) {
        ibNameLabel.text = model.name
        ibSumLabel.text = "\(model.sum)"
        ibSumLabel.textColor = UIColor.green
    } 
}
