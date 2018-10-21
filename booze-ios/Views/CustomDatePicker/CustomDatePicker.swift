//
//  CustomDatePicker.swift
//  booze-ios
//
//  Created by Владислав Марков on 21/10/2018.
//  Copyright © 2018 Владислав Марков. All rights reserved.
//

import UIKit

protocol CustomDatePickerDelegate: class {
    func cancelButtonTuched()
    func readyButtonTouched(date: Date)
}

class CustomDatePicker: UIView {
    @IBOutlet weak var ibCancelButton: UIButton!
    @IBOutlet weak var ibReadyButton: UIButton!
    @IBOutlet weak var ibDatePicker: UIDatePicker!
    
    static let height: CGFloat = 257
    
    weak var delegate: CustomDatePickerDelegate?
    
    // MARK: - Initialize
    static func xibInstance() -> CustomDatePicker {
        return UINib(nibName: "CustomDatePicker", bundle: nil).instantiate(withOwner: self, options: nil).first as! CustomDatePicker
    }
    
    // MARK: - Actions
    @IBAction func cancelButtnoTouched(_ sender: UIButton) {
        delegate?.cancelButtonTuched()
    }
    
    
    @IBAction func readyButtonTouched(_ sender: UIButton) {
        delegate?.readyButtonTouched(date: ibDatePicker.date)
    }
}
