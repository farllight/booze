//
//  AddBoozeHeaderTableView.swift
//  booze-ios
//
//  Created by Владислав Марков on 20/10/2018.
//  Copyright © 2018 Владислав Марков. All rights reserved.
//

import UIKit

class AddBoozeHeaderTableView: UIView {
    
    @IBOutlet weak var ibHeaderLabel: UILabel!
    @IBOutlet weak var ibCountLabel: UILabel!
    
    // MARK: - Initialize
    static func xibInstance() -> AddBoozeHeaderTableView {
        return UINib(nibName: "AddBoozeHeaderTableView",
                     bundle: nil).instantiate(withOwner: AddBoozeHeaderTableView.self,
                                              options: nil).first as! AddBoozeHeaderTableView
    }
    
    // MARK: - Setup UI
    func setupUI(array: [Any]) {
        ibCountLabel.text = array.countInHumanString()
    }
}
