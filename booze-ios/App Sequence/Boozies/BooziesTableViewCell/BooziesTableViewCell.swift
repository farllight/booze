//
//  BooziesTableViewCell.swift
//  booze-ios
//
//  Created by Владислав Марков on 19/10/2018.
//  Copyright © 2018 Владислав Марков. All rights reserved.
//

import UIKit

class BooziesTableViewCell: UITableViewCell {
    static let xibName = "BooziesTableViewCell"
    static let reuseId = "BooziesTableViewCellReuseId"

    @IBOutlet weak var boozeImageView: UIImageView!
    @IBOutlet weak var boozeNameLabel: UILabel!
    @IBOutlet weak var boozeDateLabel: UILabel!
    @IBOutlet weak var ibCountOfUsersLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        accessoryType = .disclosureIndicator
        boozeImageView.roundImageView()
    }
    
    func setupUI(party: Party) {
        boozeNameLabel.text = party.name
        ibCountOfUsersLabel.text = party.users!.countInHumanString()
        boozeDateLabel.text = party.date.timeStumpToHumanDate()
    }
}
