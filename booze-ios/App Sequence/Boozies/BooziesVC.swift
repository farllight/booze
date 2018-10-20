//
//  BooziesVC.swift
//  booze-ios
//
//  Created by Владислав Марков on 19/10/2018.
//  Copyright © 2018 Владислав Марков. All rights reserved.
//

import UIKit
import KVNProgress

class BooziesVC: UIViewController {
    @IBOutlet weak var ibBooziesTableView: UITableView!
    
    private var addRightBarButtonItem = UIBarButtonItem()
    private var parties = [Party]()
    
    // MARK: - Initialize
    static func storyboardInstance() -> UIViewController {
        let sb = UIStoryboard(name: "Boozies", bundle: nil)
        return sb.instantiateInitialViewController() as! BooziesVC
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }

    // MARK: - Setup UI
    private func setupUI() {
        title = "Пьянки"
        setupBooziesTableView()
        setupRightBarButtonItem()
        setupNavigationBar()
    }
    
    private func setupRightBarButtonItem() {
        addRightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                target: self,
                                                action: #selector(addRightBarButtonItemTouched))
        navigationItem.rightBarButtonItem = addRightBarButtonItem
    }
    
    private func setupBooziesTableView() {
        ibBooziesTableView.delegate = self
        ibBooziesTableView.dataSource = self
        ibBooziesTableView.register(UINib(nibName: BooziesTableViewCell.xibName, bundle: nil),
                                    forCellReuseIdentifier: BooziesTableViewCell.reuseId)
        ibBooziesTableView.tableFooterView = UIView()
    }
    
    // MARK: - Actions
    @objc private func addRightBarButtonItemTouched() {
        navigationController?.pushViewController(AddBoozeVC.storyboardInstance(), animated: true)
    }
    
    // MARK: - Load data
    private func loadData() {
        KVNProgress.show(withStatus: "Загрузка...")
        DataClient.shared.getUser(currentUserId: UserSessionTracker.shared.currentUserId) { [weak self] (user) in
            if let user = user {
                self?.parties = user.parties
                KVNProgress.dismiss()
            } else {
                KVNProgress.showError()
            }
        }
    }
}

extension BooziesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parties.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BooziesTableViewCell.reuseId, for: indexPath) as! BooziesTableViewCell
        cell.setupUI(party: parties[indexPath.row])
        
        return cell
    }
}
