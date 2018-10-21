//
//  AddBoozeVC.swift
//  booze-ios
//
//  Created by Владислав Марков on 19/10/2018.
//  Copyright © 2018 Владислав Марков. All rights reserved.
//

import UIKit
import KVNProgress
import MaterialComponents.MaterialBottomSheet

protocol AddBoozeVCDelegate: class {
    func addParty()
}

class AddBoozeVC: UIViewController {
    @IBOutlet weak var ibAddBoozeTableView: UITableView!
    
    private var customPatePicker = CustomDatePicker.xibInstance()
    
    private var addBoozeRightBarButtonItem = UIBarButtonItem()
    private var users = [User]()
    private var contants = [Contact]()
    private var name = ""
    private var date = 0
    
    weak var delegate: AddBoozeVCDelegate?
    
    // MARK: - Initialize
    static func storyboardInstance() -> AddBoozeVC {
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
        setupCustomDatePicker()
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
    
    private func setupCustomDatePicker() {
        customPatePicker.delegate = self
        
        let topY = view.frame.height - CustomDatePicker.height
        customPatePicker.frame = CGRect(x: 0, y: topY, width: view.frame.width, height: view.frame.height - topY) 
    }
    
    // MARK: - Actions
    @objc private func rightBarButtonItemTouched() {
        KVNProgress.show()
        let party = PartyRequestModel(name: name, date: date, users: contants)
        DataClient.shared.setParty(party: party) { [weak self] (isSuccess) in
            if isSuccess {
                KVNProgress.dismiss()
                self?.navigationController?.popViewController(animated: true)
                self?.delegate?.addParty()
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
            return 84
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: AddBoozeTableViewCell.reuseId, for: indexPath) as! AddBoozeTableViewCell
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
        self.contants = users
        ibAddBoozeTableView.reloadData()
        navigationController?.popViewController(animated: true)
    }
}

extension AddBoozeVC: AddBoozeTableVieCellDelegate {
    func dateTextFieldStartEditind() {
        view.addSubview(customPatePicker)
        
    }
    
    func nameTextFieldEditing(text: String) {
        name = text
    }
}

extension AddBoozeVC: CustomDatePickerDelegate {
    func cancelButtonTuched() {
        customPatePicker.removeFromSuperview()
        tabBarController?.tabBar.isHidden = false
    }
    
    func readyButtonTouched(date: Date) {
        // TODO: - send date with delegate
        customPatePicker.removeFromSuperview()
    }
}
