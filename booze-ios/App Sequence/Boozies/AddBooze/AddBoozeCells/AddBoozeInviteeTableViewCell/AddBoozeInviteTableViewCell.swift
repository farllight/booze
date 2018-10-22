//
//  AddBoozeInviteTableViewCell.swift
//  booze-ios
//
//  Created by Владислав Марков on 20/10/2018.
//  Copyright © 2018 Владислав Марков. All rights reserved.
//

import UIKit

protocol AddBoozeInviteTableViewCellDelegate: class {
    func inviteUserButtonTouched()
}

class AddBoozeInviteTableViewCell: UITableViewCell {
    static let xibName = "AddBoozeInviteTableViewCell"
    static let reuseId = "AddBoozeInviteTableViewCell"

    @IBOutlet weak var ibInviteUserButton: UIButton!
    
    weak var delegate: AddBoozeInviteTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = ColorResources.shared.cellProfileBackgroundColor
        selectionStyle = .none
    }
    
    // MARK: - Actions
    @IBAction func inviteUserButtonTouched(_ sender: UIButton) {
        delegate?.inviteUserButtonTouched()
    }
}
