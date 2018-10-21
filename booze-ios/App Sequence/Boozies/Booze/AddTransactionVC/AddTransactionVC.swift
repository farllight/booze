//
//  AddTransactionVC.swift
//  booze-ios
//
//  Created by Владислав Марков on 21/10/2018.
//  Copyright © 2018 Владислав Марков. All rights reserved.
//

import UIKit
import KVNProgress

class AddTransactionVC: UIViewController {
    @IBOutlet weak var ibContentView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var ibNameTextField: UITextField!
    @IBOutlet weak var ibSumTextField: UITextField!
    @IBOutlet weak var ibNameSeparatorView: UIView!
    @IBOutlet weak var ibSumSeparatorView: UIView!
    @IBOutlet weak var ibPhotoImageView: UIImageView!
    
    var party = Party.empty()
    
    // MARK: - Initialize
    static func storyboardInstance() -> AddTransactionVC {
        let sb = UIStoryboard(name: "AddTransaction", bundle: nil)
        return sb.instantiateInitialViewController() as! AddTransactionVC
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupColors()
    }
    
    // MARK: - Setup UI
    private func setupColors() {
        cancelButton.setTitleColor(ColorResources.shared.mainThemeColor, for: .normal)
        addButton.setTitleColor(ColorResources.shared.mainThemeColor, for: .normal)
        ibSumSeparatorView.backgroundColor = ColorResources.shared.mainThemeColor
        ibNameSeparatorView.backgroundColor = ColorResources.shared.mainThemeColor
    }

    // MARK: - Actions
    @IBAction func cancelButtonTouched(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func addButtonTouched(_ sender: Any) {
        dismiss(animated: true, completion: nil)
         
        KVNProgress.show()
        let payment = PaymentRequestModel(amount: Int(ibSumTextField.text ?? "") ?? 0,
                                          userId: UserSessionTracker.shared.currentUserId,
                                          partyId: party.id,
                                          date: Int(Date().timeIntervalSince1970),
                                          name: ibNameTextField.text ?? "")
        DataClient.shared.setPayment(payment: payment) { (isSuccess) in
            if isSuccess {
                KVNProgress.dismiss()
            } else {
                KVNProgress.showError()
            }
        }
    }
}
