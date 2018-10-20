//
//  AddBoozeVC.swift
//  booze-ios
//
//  Created by Владислав Марков on 19/10/2018.
//  Copyright © 2018 Владислав Марков. All rights reserved.
//

import UIKit
import KVNProgress

class AddBoozeVC: UIViewController {
    @IBOutlet weak var ibAddBoozeTableView: UITableView!
    
    private var addBoozeRightBarButtonItem = UIBarButtonItem()
    private var users = [User]()
    private var name = ""
    private var date = 0
    
    // MARK: - Initialize
    static func storyboardInstance() -> UIViewController {
        let sb = UIStoryboard(name: "AddBooze", bundle: nil)
        return sb.instantiateInitialViewController() as! AddBoozeVC
    }
    
    // MARK: - Lifecylce
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        title = "Создать вечеринку"
        setupTable()
        setupRightBarButtonItem()
        setupNavigationBar()
    }
    
    private func setupTable() {
        ibAddBoozeTableView.delegate = self
        ibAddBoozeTableView.dataSource = self
        ibAddBoozeTableView.register(UINib(nibName: AddBoozeTableViewCell.xibName, bundle: nil), forCellReuseIdentifier: AddBoozeTableViewCell.reuseId)
        ibAddBoozeTableView.register(UINib(nibName: AddBoozeUserTableViewCell.xibName, bundle: nil), forCellReuseIdentifier: AddBoozeUserTableViewCell.reuseId)
        ibAddBoozeTableView.register(UINib(nibName: AddBoozeInviteTableViewCell.xibName, bundle: nil), forCellReuseIdentifier: AddBoozeInviteTableViewCell.reuseId)
        ibAddBoozeTableView.tableFooterView = UIView()
        ibAddBoozeTableView.separatorStyle = .none
    }
    
    private func setupRightBarButtonItem() {
        addBoozeRightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                     target: self,
                                                     action: #selector(rightBarButtonItemTouched))
        navigationItem.rightBarButtonItem = addBoozeRightBarButtonItem
    }
    
    // MARK: - Actions
    @objc private func rightBarButtonItemTouched() {
        KVNProgress.show()
        DataClient.shared.setParty(party: Party(name: name, date: date, users: users)) { (isSuccess) in
            if isSuccess {
                KVNProgress.dismiss()
            } else {
                KVNProgress.showError()
            }
        }
    }
}

extension AddBoozeVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRows = 0
        
        if section == 0 {
            numberOfRows = 1
        } else {
            numberOfRows = users.count + 1
        }
        
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let view = AddBoozeHeaderTableView.xibInstance()
            view.setupUI(array: users)
            
            return view
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 204
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: AddBoozeTableViewCell.reuseId, for: indexPath) as! AddBoozeTableViewCell
            cell.setupUI(model: AddBoozeTableViewCellModel(image: ImageResources.shared.profileAvatarMock, name: "", date: Date()))
            cell.delegate = self
            return cell
        } else if indexPath.section == 1 && indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: AddBoozeInviteTableViewCell.reuseId, for: indexPath) as! AddBoozeInviteTableViewCell
            cell.delegate = self
            
            return cell
        } else  {
            let cell = tableView.dequeueReusableCell(withIdentifier: AddBoozeUserTableViewCell.reuseId, for: indexPath) as! AddBoozeUserTableViewCell
            cell.setup(user: users[indexPath.row - 1])
            return cell
        }
    }
}

extension AddBoozeVC: AddBoozeInviteTableViewCellDelegate {
    func inviteUserButtonTouched() {
        let vc = ContactsVC.storyboardInstance()
        vc.delegate = self
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension AddBoozeVC: ContactVCDelegate {
    func readyBarButtonTouched(users: [Contact]) {
        self.users = users.map({ $0.toUser() })
        ibAddBoozeTableView.reloadData()
        navigationController?.popViewController(animated: true)
    }
}

extension AddBoozeVC: AddBoozeTableVieCellDelegate {
    func nameTextFieldEditing(text: String) {
        name = text
    }
    
    func dateTextFieldEditind(text: String) {
        date = text.toTimeStumpInt()
    }
}
