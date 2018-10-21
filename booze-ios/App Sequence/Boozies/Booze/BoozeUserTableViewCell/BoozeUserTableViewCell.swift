//
//  BoozeUserTableViewCell.swift
//  booze-ios
//
//  Created by Владислав Марков on 21/10/2018.
//  Copyright © 2018 Владислав Марков. All rights reserved.
//

import UIKit
import SDWebImage

class BoozeUserTableViewCell: UITableViewCell {
    static let xibName = "BoozeUserTableViewCell"
    static let reuseId = "BoozeUserTableViewCellReuseId"

    @IBOutlet weak var ibAvatarImageView: UIImageView!
    @IBOutlet weak var ibNameLabel: UILabel!
    @IBOutlet weak var ibBalanceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ibAvatarImageView.roundImageView()
    }

    func setup(user: User) {
        ibAvatarImageView.sd_setImage(with: URL(string: user.avatar ?? ""), placeholderImage: ImageResources.shared.profileAvatarMock)
        ibNameLabel.text = user.name
        ibBalanceLabel.text = "\(user.balance ?? 0)"
        
        if (user.balance ?? 0) > 0.0 {
            ibBalanceLabel.textColor = UIColor.green
        } else if (user.balance  ?? 0) < 0.0 {
            ibBalanceLabel.textColor = UIColor.red
        }
    }
}
