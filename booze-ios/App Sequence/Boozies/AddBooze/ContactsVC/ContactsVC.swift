//
//  ContactsVC.swift
//  booze-ios
//
//  Created by Владислав Марков on 20/10/2018.
//  Copyright © 2018 Владислав Марков. All rights reserved.
//

import UIKit

protocol ContactVCDelegate: class {
    func readyBarButtonTouched(users: [Contact])
}

class ContactsVC: UIViewController {
    @IBOutlet weak var ibContactTableView: UITableView!
    
    @objc private var readyRightBarButtonItem = UIBarButtonItem()
    
    private var contacts = [Contact]()
    private var contantsForInvite = Set<Contact>()
    
    weak var delegate: ContactVCDelegate?
    
    // MARK: - Initialize
    static func storyboardInstance() -> ContactsVC {
        let sb = UIStoryboard(name: "Contacts", bundle: nil)
        return sb.instantiateInitialViewController() as! ContactsVC
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        setupUI()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        title = "Список контактов"
        self.setupTable()
        setupNavigationBar()
        setupRightBarButtonItem()
    }
    
    private func setupTable() {
        ibContactTableView.delegate = self
        ibContactTableView.dataSource = self
        ibContactTableView.tableFooterView = UIView()
        ibContactTableView.register(UINib(nibName: ContactTableViewCell.xibName, bundle: nil),
                                    forCellReuseIdentifier: ContactTableViewCell.reuseId)
    }
    
    private func setupRightBarButtonItem() {
//        readyRightBarButtonItem = UIBarButtonItem(title: "Готово",
//                                                   style: .plain,
//                                                   target: self,
//                                                   action: #selector(readyRightBarButtonItem))
        readyRightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                  target: self,
                                                  action: #selector(createRigthBarButtonItemTouched))
        navigationItem.rightBarButtonItem = readyRightBarButtonItem
    }
    
    // MARK: - Load data
    private func loadData() {
        contacts = ContactsClient.shared.getAllContactList()
        contacts = contacts.sorted { ($0.name ?? "") < ($1.name ?? "") }
    }
    
    // MARK: - Actions
    @objc private func createRigthBarButtonItemTouched() {
        delegate?.readyBarButtonTouched(users: Array(contantsForInvite))
    }
}

extension ContactsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactTableViewCell.reuseId, for: indexPath) as! ContactTableViewCell
        cell.setup(contact: contacts[indexPath.row])
        cell.delegate = self
        
        return cell
    }
}

extension ContactsVC: ContactTableViewCellDelegate {
    func checkboxButtonTouched(isOn: Bool, cell: ContactTableViewCell) {
        guard let indexPath = ibContactTableView.indexPath(for: cell) else {
            return
        }
        
        if isOn {
            contantsForInvite.insert(contacts[indexPath.row])
        } else {
            contantsForInvite.remove(contacts[indexPath.row])
        }
    }
}


