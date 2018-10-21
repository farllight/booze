//
//  AuthVC.swift
//  booze-ios
//
//  Created by Владислав Марков on 20/10/2018.
//  Copyright © 2018 Владислав Марков. All rights reserved.
//

import UIKit
import KVNProgress

class AuthVC: UIViewController {
    @IBOutlet weak var ibPhoneTitleLabel: UILabel!
    @IBOutlet weak var ibDescriptionLabel: UILabel!
    @IBOutlet weak var ibPhoneTextField: UITextField!
    @IBOutlet weak var ibSepatorView: UIView!
    @IBOutlet weak var ibSendCodeButton: UIButton!
    @IBOutlet weak var ibNameTextField: UITextField!
    @IBOutlet weak var ibSepatorNameView: UIView!
    
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
        title = "Вход"
        setupColors()
        setupNavigationBar()
    }
    
    private func setupColors() {
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
        ibNameTextField.keyboardType = .namePhonePad
        ibNameTextField.attributedText = NSAttributedString(string: "Имя", attributes: [
            NSAttributedString.Key.foregroundColor: ColorResources.shared.authTextFieldColor
            ])
        ibNameTextField.textColor = .white
        ibSepatorNameView.backgroundColor = ColorResources.shared.authTextFieldColor
    }
    
    
    // MARK: - Actions
    @IBAction func sendCodeButtonTouched(_ sender: UIButton) {
        KVNProgress.show()
        DataClient.shared.registration(phone: ibPhoneTextField.text ?? "", name: ibNameTextField.text ?? "") { [weak self] (isSuccess)  in
            if isSuccess {
                KVNProgress.dismiss()
                let vc = CodeConformitionVC.storyboardInstance()
                vc.phone = self?.ibPhoneTextField.text ?? ""
                vc.name = self?.ibNameTextField.text ?? ""
                self?.navigationController?.pushViewController(vc, animated: true)
            } else {
                KVNProgress.showError()
            }
        }
    }
}
