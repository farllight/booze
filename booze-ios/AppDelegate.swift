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
        window?.rootViewController = MainTabBarController()
        
//        UINavigationBar.appearance().backgroundColor = ColorResources.shared.purple
//        UINavigationBar.appearance().tintColor = .white
        
        return true
    }
}

