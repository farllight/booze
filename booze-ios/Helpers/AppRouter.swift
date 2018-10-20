//
//  AppRouter.swift
//  booze-ios
//
//  Created by Владислав Марков on 20/10/2018.
//  Copyright © 2018 Владислав Марков. All rights reserved.
//

import UIKit

class AppRouter {
    static let shared = AppRouter()
    
    private init() {
        
    }
    
    func replaceRootViewController(viewController: UIViewController) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        guard let window = appDelegate.window else { return }

        UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromTop, animations: {
            window.rootViewController = viewController
        }, completion: nil)
    } 
}
