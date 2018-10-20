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
        setupProfileTableView()
    }
    
    private func setupProfileTableView() {
        ibProfileTableView.delegate = self
        ibProfileTableView.dataSource = self
        ibProfileTableView.tableFooterView = UIView()
        ibProfileTableView.separatorStyle = .none
        ibProfileTableView.register(UINib(nibName: ProfileUserTableViewCell.xibName, bundle: nil),
                                    forCellReuseIdentifier: ProfileUserTableViewCell.reuseId)
        ibProfileTableView.register(UINib(nibName: ProfileSwitchTableViewCell.xibName, bundle: nil),
                                    forCellReuseIdentifier: ProfileSwitchTableViewCell.reuseId)
        ibProfileTableView.register(UINib(nibName: ProfileTableViewCell.xibName, bundle: nil),
                                    forCellReuseIdentifier: ProfileTableViewCell.reuseId)
        ibProfileTableView.register(UINib(nibName: ProfileExitTableViewCell.xibName, bundle: nil),
                                    forCellReuseIdentifier: ProfileExitTableViewCell.reuseId)

    }
    
    // MARK: - Load data
    private func loadDataForMenu() {
        // TODO: - Load profile data
        menuSections = [
            ProfileTableViewCellModel(name: "Должники", count: 9, sum: 4500),
            ProfileTableViewCellModel(name: "Я должен", count: 9, sum: 4500),
        ]
    }
}

extension ProfileVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 44))
        view.backgroundColor = .white
        
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (section == 2) ? menuSections.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileUserTableViewCell.reuseId, for: indexPath) as! ProfileUserTableViewCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileSwitchTableViewCell.reuseId, for: indexPath) as! ProfileSwitchTableViewCell
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.reuseId, for: indexPath) as! ProfileTableViewCell
            cell.setup(model: menuSections[indexPath.row])
            if indexPath.row != menuSections.count - 1 {
                cell.ibBottomBorderView.isHidden = true
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileExitTableViewCell.reuseId, for: indexPath) as! ProfileExitTableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 3 {
            showLogoutAlert(yesCompletion: {
                UserSessionTracker.shared.logout()
                AppRouter.shared.replaceRootViewController(viewController: UINavigationController(rootViewController: AuthVC.storyboardInstance()))
            }) { }
        }
    }
}
