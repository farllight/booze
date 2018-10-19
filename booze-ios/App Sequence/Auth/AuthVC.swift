//
//  AuthVC.swift
//  booze-ios
//
//  Created by Владислав Марков on 20/10/2018.
//  Copyright © 2018 Владислав Марков. All rights reserved.
//

import UIKit

class AuthVC: UIViewController {
    @IBOutlet weak var ibPhoneTitleLabel: UILabel!
    @IBOutlet weak var ibDescriptionLabel: UILabel!
    @IBOutlet weak var ibPhoneTextField: UITextField!
    @IBOutlet weak var ibSepatorView: UIView!
    @IBOutlet weak var ibSendCodeButton: UIButton!
    
    // MARK: - Initialize
    static func storyboardInstance() -> AuthVC {
        let sb = UIStoryboard(name: "Auth", bundle: nil)
        return sb.instantiateInitialViewController() as! AuthVC
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = ColorResources.shared.mainThemeColor
        ibPhoneTitleLabel.textColor = .white
        ibPhoneTextField.textColor = .white
        ibDescriptionLabel.textColor = .white
        ibSepatorView.backgroundColor = ColorResources.shared.authTextFieldColor
        ibSendCodeButton.setTitleColor(.white, for: .normal)
        
        ibPhoneTextField.keyboardType = .numberPad
        ibPhoneTextField.attributedPlaceholder = NSAttributedString(string: "Номер телефона",
                                                                    attributes: [
                                                                        NSAttributedString.Key.foregroundColor: ColorResources.shared.authTextFieldColor
            ])
    }
    
    // MARK: - Actions
    @IBAction func sendCodeButtonTouched(_ sender: UIButton) {
        // Send request on server for code
    }
}
