//
//  ProfileVC.swift
//  booze-ios
//
//  Created by Владислав Марков on 19/10/2018.
//  Copyright © 2018 Владислав Марков. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    @IBOutlet weak var ibProfileTableView: UITableView!
    @IBOutlet weak var ibRemindButton: UIButton!
    
    private var menuSections = [ProfileTableViewCellModel]()
    
    // MARK: - Initialize
    static func storyboardInstance() -> UIViewController {
        let sb = UIStoryboard(name: "Profile", bundle: nil)
        return sb.instantiateInitialViewController() as! ProfileVC
    } 
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDataForMenu()
        setupUI()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        title = "Профиль"
        setupNavigationBar()
        setupRemindButton()
        setupProfileTableView()
    }
    
    private func setupProfileTableView() {
        ibProfileTableView.delegate = self
        ibProfileTableView.dataSource = self
        ibProfileTableView.isScrollEnabled = false
        ibProfileTableView.register(UINib(nibName: ProfileTableViewCell.xibName, bundle: nil),
                                    forCellReuseIdentifier: ProfileTableViewCell.reuseId)
    }
    
    private func setupRemindButton() {
        ibRemindButton.layer.cornerRadius = 5
    }
    
    // MARK: - Actions
    @IBAction func remindButtonTouched(_ sender: UIButton) {
        // TODO: - Sending notifications
    }
    
    // MARK: - Load data
    private func loadDataForMenu() {
        // TODO: - Load profile data
        
        menuSections = [
            ProfileTableViewCellModel(name: "Мои события", additionalInformation: ""),
            ProfileTableViewCellModel(name: "Мне должны", additionalInformation: "деньги"),
            ProfileTableViewCellModel(name: "Я должна", additionalInformation: "деньги")
        ]
    }
}

extension ProfileVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuSections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.reuseId, for: indexPath) as! ProfileTableViewCell
        cell.setupUI(model: menuSections[indexPath.row])
        
        if indexPath.row == 0 {
            cell.accessoryType = .disclosureIndicator
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            // TODO: - show my events
        }
    }
}
