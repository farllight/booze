//
//  AddBoozeUserTableViewCell.swift
//  booze-ios
//
//  Created by Владислав Марков on 20/10/2018.
//  Copyright © 2018 Владислав Марков. All rights reserved.
//

import UIKit

class AddBoozeUserTableViewCell: UITableViewCell {
    static let xibName = "AddBoozeUserTableViewCell"
    static let reuseId = "AddBoozeUserTableViewCellReuseId"
    
    @IBOutlet weak var ibUserAvatar: UIImageView!
    @IBOutlet weak var ibNameLabel: UILabel!
    @IBOutlet weak var ibUserStatusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ibUserAvatar.roundImageView()
        contentView.backgroundColor = ColorResources.shared.cellProfileBackgroundColor
        selectionStyle = .none
    } 
    
    func setup(user: User) {
        ibNameLabel.text = user.name
    }
    
    
}
