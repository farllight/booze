//
//  AddBoozeTableViewCell.swift
//  booze-ios
//
//  Created by Владислав Марков on 20/10/2018.
//  Copyright © 2018 Владислав Марков. All rights reserved.
//

import UIKit

protocol AddBoozeTableVieCellDelegate: class {
    func nameTextFieldEditing(text: String)
    func dateTextFieldEditind(text: String)
}

class AddBoozeTableViewCell: UITableViewCell {
    static let xibName = "AddBoozeTableViewCell"
    static let reuseId = "AddBoozeTableViewCellReuseId"

    @IBOutlet weak var ibHeaderImageView: UIImageView!
    @IBOutlet weak var ibNameTextField: UITextField!
    @IBOutlet weak var ibDateTextField: UITextField!
    
    weak var delegate: AddBoozeTableVieCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ibHeaderImageView.roundImageView()
        contentView.backgroundColor = ColorResources.shared.cellProfileBackgroundColor
        ibNameTextField.delegate = self
        ibDateTextField.delegate = self
    }
    
    func setupUI(model: AddBoozeTableViewCellModel) {
        ibHeaderImageView.image = model.image
        ibNameTextField.text = model.name
        ibDateTextField.text = model.date.toHumanString()
    }
}

extension AddBoozeTableViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == ibNameTextField {
            delegate?.nameTextFieldEditing(text: textField.text ?? "")
        } else if (textField == ibDateTextField) {
            delegate?.dateTextFieldEditind(text: textField.text ?? "")
        }
    }
}
