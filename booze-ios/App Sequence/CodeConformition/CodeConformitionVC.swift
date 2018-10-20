//
//  CodeConformitionVC.swift
//  booze-ios
//
//  Created by Владислав Марков on 20/10/2018.
//  Copyright © 2018 Владислав Марков. All rights reserved.
//

import UIKit

class CodeConformitionVC: UIViewController {
    @IBOutlet weak var ibPhoneLabel: UILabel!
    @IBOutlet weak var ibInformationLabel: UILabel!
    @IBOutlet weak var ibCodeConformitionTextField: UITextField!
    @IBOutlet weak var ibSepatorView: UIView!
    @IBOutlet weak var ibContinieButton: UIButton!
    @IBOutlet weak var ibNotGetCodeButton: UIButton!
    
    // MARK: - Initialize
    static func storyboardInstance() -> CodeConformitionVC {
        let sb = UIStoryboard(name: "CodeConformition", bundle: nil)
        return sb.instantiateInitialViewController() as! CodeConformitionVC
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        setupColors()
        setupNavigationBar()
    }
    
    private func setupColors() {
        view.backgroundColor = ColorResources.shared.mainThemeColor
        ibPhoneLabel.textColor = .white
        ibInformationLabel.textColor = .white
        ibCodeConformitionTextField.textColor = .white
        ibCodeConformitionTextField.attributedPlaceholder = NSAttributedString(string: "Код подтверждения",
                                                                               attributes: [
                                                                                NSAttributedString.Key.foregroundColor: UIColor.white
            ])
        ibSepatorView.backgroundColor = .white
        ibContinieButton.setTitleColor(.white, for: .normal)
        ibNotGetCodeButton.setTitleColor(.white, for: .normal)
    }
    
    // MARK: - Actions
    @IBAction func contibitButtonTouched(_ sender: UIButton) {
        // TODO: - send request
    }
    
    @IBAction func notGetCodeButtonTouched(_ sender: Any) {
        // TODO: - Senf request
    }
}
