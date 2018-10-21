//
//  BoozeTransactionTableViewCell.swift
//  booze-ios
//
//  Created by Владислав Марков on 21/10/2018.
//  Copyright © 2018 Владислав Марков. All rights reserved.
//

import Foundation
import SDWebImage

class BoozeTransactionTableViewCell: UITableViewCell {
    static let xibName = "BoozeTransactionTableViewCell"
    static let reuseId = "BoozeTransactionTableViewCellReuseId"
    
    @IBOutlet weak var ibUserAvatarImageView: UIImageView!
    @IBOutlet weak var ibMessageLabel: UILabel!
    @IBOutlet weak var ibTargetUserAvatarImageView: UIImageView!
    
    func setup(transaction: Transaction) {
        ibUserAvatarImageView.sd_setImage(with: URL(string: transaction.user?.avatar ?? ""), placeholderImage: ImageResources.shared.profileAvatarMock)
        ibTargetUserAvatarImageView.sd_setImage(with: URL(string: transaction.targetUser?.avatar ?? ""), placeholderImage: ImageResources.shared.profileAvatarMock)
        ibMessageLabel.attributedText = buildMessage(tranaction: transaction)
    }
    
    private func buildMessage(tranaction: Transaction) -> NSAttributedString {
        let message = NSMutableAttributedString(string: "")
        
        let paramsForNames = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .bold)
        ]
        let firstName = NSAttributedString(string: "\(tranaction.user?.name ?? "") \(tranaction.user?.surname ?? "")", attributes: paramsForNames)
        message.append(firstName)
        
        let transactionCountText = NSAttributedString(string: " перевел на сумму \(tranaction.amount) руб ")
        message.append(transactionCountText)
        
        let secondName = NSAttributedString(string: "\(tranaction.targetUser?.name ?? "") \(tranaction.targetUser?.surname ?? "")", attributes: paramsForNames)
        message.append(secondName)
        
        return message
    }
}
