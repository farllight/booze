//
//  ProfileExitTableViewCell.swift
//  booze-ios
//
//  Created by Владислав Марков on 20/10/2018.
//  Copyright © 2018 Владислав Марков. All rights reserved.
//

import UIKit

class ProfileExitTableViewCell: UITableViewCell {
    static let xibName = "ProfileExitTableViewCell"
    static let reuseId = "ProfileExitTableViewCellReuseId"
    
    @IBOutlet weak var ibExitLabel: UILabel!
    @IBOutlet weak var topBorderView: UIView!
    @IBOutlet weak var bottomBorderView: UIView!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = ColorResources.shared.cellProfileBackgroundColor
        topBorderView.backgroundColor = ColorResources.shared.cellProfileBorderColor
        bottomBorderView.backgroundColor = ColorResources.shared.cellProfileBorderColor
    }
}
