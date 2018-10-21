//
//  BoozeVC.swift
//  booze-ios
//
//  Created by Владислав Марков on 21/10/2018.
//  Copyright © 2018 Владислав Марков. All rights reserved.
//

import UIKit

enum BoozeVCState: Int {
    case users
    case history
}

class BoozeVC: UIViewController {
    @IBOutlet weak var ibSegmentedControl: UISegmentedControl!
    @IBOutlet weak var ibTableView: UITableView!
    
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
    
    // MARK: - Actions
    @IBAction func segmentedContorlerValueChanged(_ sender: UISegmentedControl) {
        state = BoozeVCState(rawValue: sender.selectedSegmentIndex) ?? .users
        ibTableView.reloadData()
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
