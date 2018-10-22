//
//  BoozeVC.swift
//  booze-ios
//
//  Created by Владислав Марков on 21/10/2018.
//  Copyright © 2018 Владислав Марков. All rights reserved.
//

import UIKit
import KVNProgress
import MaterialComponents

enum BoozeVCState: Int {
    case users
    case history
}

class BoozeVC: UIViewController {
    @IBOutlet weak var ibSegmentedControl: UISegmentedControl!
    @IBOutlet weak var ibTableView: UITableView!
    
    private var addBarButtonItem = UIBarButtonItem()
    
    var party = Party.empty()
    private var state = BoozeVCState.users
    
    // MARK: - Initialize
    static func storyboardInstance() -> BoozeVC {
        let sb = UIStoryboard(name: "Booze", bundle: nil)
        return sb.instantiateInitialViewController() as! BoozeVC
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        title = party.name
        setupTable()
        setupSegmentedControl()
        setupNavigationBar()
        setupAddBarButtonItem()
    }
    
    private func setupTable() {
        ibTableView.delegate = self
        ibTableView.dataSource = self
        ibTableView.tableFooterView = UIView()
        ibTableView.register(UINib(nibName: BoozeUserTableViewCell.xibName, bundle: nil),
                             forCellReuseIdentifier: BoozeUserTableViewCell.reuseId)
        ibTableView.register(UINib(nibName: BoozeTransactionTableViewCell.xibName, bundle: nil), forCellReuseIdentifier: BoozeTransactionTableViewCell.reuseId)
    }
    
    private func setupSegmentedControl() {
        ibSegmentedControl.tintColor = ColorResources.shared.mainThemeColor
    }
    
    private func setupAddBarButtonItem() {
        addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                           target: self,
                                           action: #selector(addBarButtonItemTouched))
        navigationItem.rightBarButtonItem = addBarButtonItem
    }
    
    // MARK: - Actions
    @IBAction func segmentedContorlerValueChanged(_ sender: UISegmentedControl) {
        state = BoozeVCState(rawValue: sender.selectedSegmentIndex) ?? .users
        ibTableView.reloadData()
    }
    
    @objc private func addBarButtonItemTouched() {
        let alertController = UIAlertController(title: "Добавение", message: "", preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Добавить пользователя",
                                                style: .default,
                                                handler: { [weak self] (action) in
            let vc = ContactsVC.storyboardInstance()
            vc.delegate = self
    
            self?.navigationController?.pushViewController(vc, animated: true)
        }))
        
        alertController.addAction(UIAlertAction(title: "Добавить транзакцию",
                                                style: .default,
                                                handler: { [weak self] (action) in
                let vc  = AddTransactionVC.storyboardInstance()
                vc.party = self?.party ?? Party.empty()
                self?.present(MDCBottomSheetController(contentViewController: vc), animated: true, completion: nil)
        }))
        
        alertController.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }
}

extension BoozeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRows = 0
        
        switch state {
        case .users:
            numberOfRows = party.users.count
        case .history:
            numberOfRows = party.transactions.count
        }
        
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch state {
        case .users:
            let cell = tableView.dequeueReusableCell(withIdentifier: BoozeUserTableViewCell.reuseId, for: indexPath) as! BoozeUserTableViewCell
            cell.setup(user: party.users[indexPath.row])
            return cell
        case .history:
            let cell = tableView.dequeueReusableCell(withIdentifier: BoozeTransactionTableViewCell.reuseId, for: indexPath) as! BoozeTransactionTableViewCell
            cell.setup(transaction: party.transactions[indexPath.row])
            
            return cell
        }
    } 
}

extension BoozeVC: ContactVCDelegate {
    func readyBarButtonTouched(users: [Contact]) {
        party.users = users.map({  $0.toUser() })
        
        KVNProgress.show()
        DataClient.shared.updateParty(partyId: party.id, party: party.toPartyRequestModel()) { [weak  self] (party) in
            if let party = party {
                self?.navigationController?.popViewController(animated: true)
                self?.party = party
                self?.ibTableView.reloadData()
                KVNProgress.dismiss()
            } else {
                KVNProgress.showError()
            }
        }
    }
}
