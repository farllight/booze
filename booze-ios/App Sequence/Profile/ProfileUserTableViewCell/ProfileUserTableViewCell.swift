//
//  ProfileUserTableViewCell.swift
//  booze-ios
//
//  Created by Владислав Марков on 20/10/2018.
//  Copyright © 2018 Владислав Марков. All rights reserved.
//

import UIKit

class ProfileUserTableViewCell: UITableViewCell {
    static let xibName = "ProfileUserTableViewCell"
    static let reuseId = "ProfileUserTableViewCellReuseId"
    
    @IBOutlet weak var ibAvatarImageView: UIImageView!
    @IBOutlet weak var ibNameLabel: UILabel!
    @IBOutlet weak var ibPhoneLabel: UILabel!
    @IBOutlet weak var ibTopBorderView: UIView!
    @IBOutlet weak var ibBottomBorderView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = ColorResources.shared.cellProfileBackgroundColor
        ibAvatarImageView.roundImageView()
        ibTopBorderView.backgroundColor = ColorResources.shared.cellProfileBorderColor
        ibBottomBorderView.backgroundColor = ColorResources.shared.cellProfileBorderColor
    }
}
