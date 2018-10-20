//
//  UIViewController+LogoutAlert.swift
//  booze-ios
//
//  Created by Владислав Марков on 20/10/2018.
//  Copyright © 2018 Владислав Марков. All rights reserved.
//

import UIKit

extension UIViewController {
    func showLogoutAlert(yesCompletion: @escaping () -> Void, noCompletion: @escaping () -> Void) {
        let alert = UIAlertController(title: "Выход", message: "Вы действительно хотите выйти", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Да", style: .default, handler: { (action) in
            yesCompletion()
        }))
        
        alert.addAction(UIAlertAction(title: "Нет", style: .destructive, handler: { (alert) in
            noCompletion()
        }))
        
        present(alert, animated: true, completion: nil)
    }
}
