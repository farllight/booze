//
//  MainTabBarController.swift
//  booze-ios
//
//  Created by Владислав Марков on 19/10/2018.
//  Copyright © 2018 Владислав Марков. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addViewControllers()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        tabBar.tintColor = ColorResources.shared.mainThemeColor
    }
    
    private func addViewControllers() {
        viewControllers = [
            addBoozies(),
            addProfile()
        ]
    }
    
    private func addBoozies() -> UIViewController {
        let vc = BooziesVC.storyboardInstance()
        vc.tabBarItem.title = "Вечеринки"
        vc.tabBarItem.image = ImageResources.shared.champagne
        
        return UINavigationController(rootViewController: vc)
    }
    
    private func addProfile() -> UIViewController {
        let vc = ProfileVC.storyboardInstance()
        vc.tabBarItem.title = "Профиль"
        vc.tabBarItem.image = ImageResources.shared.profile
        
        return UINavigationController(rootViewController: vc)
    }
}
