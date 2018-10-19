//
//  AddBoozeVC.swift
//  booze-ios
//
//  Created by Владислав Марков on 19/10/2018.
//  Copyright © 2018 Владислав Марков. All rights reserved.
//

import UIKit
import Eureka

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
        }
        
        <<< DateRow() {
            $0.title = "Дата"
        }
        
        <<< ButtonRow() {
            $0.title = "Добавить участников"
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
        // TODO: - create booze
    }
}
