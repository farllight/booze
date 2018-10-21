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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadData()
    }

    // MARK: - Setup UI
    private func setupUI() {
        title = "Вечеринки"
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
        let vc = AddBoozeVC.storyboardInstance()
        vc.delegate = self
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Load data
    private func loadData() {
        KVNProgress.show(withStatus: "Загрузка...")
        DataClient.shared.getAllParties { [weak self] (parties) in
            if let parties = parties {
                self?.parties = parties
                self?.ibBooziesTableView.reloadData()
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = BoozeVC.storyboardInstance()
        vc.party = parties[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension BooziesVC: AddBoozeVCDelegate {
    func addParty() {
        loadData()
    }
}
