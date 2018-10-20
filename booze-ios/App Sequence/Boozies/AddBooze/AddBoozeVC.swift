//
//  AddBoozeVC.swift
//  booze-ios
//
//  Created by Владислав Марков on 19/10/2018.
//  Copyright © 2018 Владислав Марков. All rights reserved.
//

import UIKit
import Eureka
import KVNProgress

class AddBoozeVC: FormViewController {
    private var createBoozeRightBarButtonItem = UIBarButtonItem()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        title = "Создать пьянку"
        setupForm()
        setupCreateBoozyBarButtonItem()
        setupNavigationBar()
    }
    
    private func setupForm() {
        form +++ Section()
        <<< TextRow() {
            $0.title = "Название"
            $0.tag = "Name"
        }
        
        <<< DateRow() {
            $0.title = "Дата"
            $0.tag = "Date"
        }
        
        <<< ButtonRow() {
            $0.title = "Добавить участников"
            $0.tag = "AddUser"
        }
    }
    
    private func setupCreateBoozyBarButtonItem() {
        createBoozeRightBarButtonItem = UIBarButtonItem(title: "Готово",
                                                        style: .plain,
                                                        target: self,
                                                        action: #selector(createBoozeRightBarButtonItemTouched))
        navigationItem.rightBarButtonItem = createBoozeRightBarButtonItem
    }
    
    // MARK: - Actions
    @objc private func createBoozeRightBarButtonItemTouched() {
        KVNProgress.show()
        
        if let party = buildParty() {
            DataClient.shared.setParty(party: party) { [weak self] (isSuccess) in
                if isSuccess {
                    KVNProgress.dismiss()
                    self?.navigationController?.popViewController(animated: true)
                } else {
                    KVNProgress.showError()
                }
            }
        } else {
            KVNProgress.showError(withStatus: "Заполнены не все поля!")
        }
    }
     
    private func buildParty() -> Party? {
        guard let name = form.rowBy(tag: "Name")?.baseValue as? String,
            let date = form.rowBy(tag: "Date")?.baseValue as? Date else {
                return nil
        }
        
        return Party(name: name,
                     date: Int(date.timeIntervalSince1970),
                     users: [])        
    }
}
