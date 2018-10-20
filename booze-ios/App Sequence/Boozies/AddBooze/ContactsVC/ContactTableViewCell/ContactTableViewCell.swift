//
//  ContactTableViewCell.swift
//  booze-ios
//
//  Created by Владислав Марков on 20/10/2018.
//  Copyright © 2018 Владислав Марков. All rights reserved.
//

import UIKit

protocol ContactTableViewCellDelegate: class {
    func checkboxButtonTouched(isOn: Bool, cell: ContactTableViewCell)
}

class ContactTableViewCell: UITableViewCell {
    static let xibName = "ContactTableViewCell"
    static let reuseId = "ContactTableViewCellReuseId"
    
    @IBOutlet weak var ibCheckboxButton: UIButton!
    @IBOutlet weak var ibNameLabel: UILabel!
    @IBOutlet weak var ibPhoneNumberLabel: UILabel!
    
    weak var delegate: ContactTableViewCellDelegate?
    private var isOn = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ibCheckboxButton.addTarget(self, action: #selector(checkboxButtonTouched), for: .touchUpInside)
        selectionStyle = .none
        setupCheckboxButton()
    }

    func setup(contact: Contact) {
        ibNameLabel.text = "\(contact.name ?? "") \(contact.surname ?? "")"
        ibPhoneNumberLabel.text = contact.phone
    }
    
    private func setupCheckboxButton() {
        ibCheckboxButton.layer.borderColor = ColorResources.shared.blueCheckboxBorderColor.cgColor
        ibCheckboxButton.layer.cornerRadius = ibCheckboxButton.frame.height / 2
        ibCheckboxButton.layer.borderWidth = 1
        ibCheckboxButton.clipsToBounds = true
    }

    // MARK: - Actions
    @objc private func checkboxButtonTouched() {
        if isOn {
            ibCheckboxButton.setImage(UIImage(), for: .normal)
        } else {
            ibCheckboxButton.setImage(ImageResources.shared.checkbox, for: .normal)
        }
        isOn = !isOn
        
        delegate?.checkboxButtonTouched(isOn: isOn, cell: self)
    }
}
