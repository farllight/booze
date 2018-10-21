//
//  ProfileSwitchTableViewCell.swift
//  booze-ios
//
//  Created by Владислав Марков on 20/10/2018.
//  Copyright © 2018 Владислав Марков. All rights reserved.
//

import UIKit

protocol ProfileSwitchTableViewCellDelegate: class {
    func switchValueChanged(isOn: Bool)
}

class ProfileSwitchTableViewCell: UITableViewCell {
    static let xibName = "ProfileSwitchTableViewCell"
    static let reuseId = "ProfileSwitchTableViewCellReuseId"

    @IBOutlet weak var ibNotificationSwitch: UISwitch!
    @IBOutlet weak var ibNotificationNameLabel: UILabel!
    @IBOutlet weak var ibTopBorderView: UIView!
    @IBOutlet weak var ibBottomBorderView: UIView!
    
    weak var delegate: ProfileSwitchTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = ColorResources.shared.cellProfileBackgroundColor
        ibTopBorderView.backgroundColor = ColorResources.shared.cellProfileBorderColor
        ibBottomBorderView.backgroundColor = ColorResources.shared.cellProfileBorderColor
        selectionStyle = .none
    }
    
    func setup(delegate: ProfileSwitchTableViewCellDelegate, isOn: Bool) {
        self.delegate = delegate
        ibNotificationSwitch.isOn = isOn
        
    }
    
    @IBAction func notificationSwitchValueChanged(_ sender: UISwitch) {
        delegate?.switchValueChanged(isOn: sender.isOn)
    }
}
