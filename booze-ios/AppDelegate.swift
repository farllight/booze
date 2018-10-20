//
//  AppDelegate.swift
//  booze-ios
//
//  Created by Владислав Марков on 19/10/2018.
//  Copyright © 2018 Владислав Марков. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window?.makeKeyAndVisible()

        if UserSessionTracker.shared.isAuth() {
            window?.rootViewController = MainTabBarController()
        } else {
            window?.rootViewController = UINavigationController(rootViewController: AuthVC.storyboardInstance())
        } 
        
        return true 
    }
}

