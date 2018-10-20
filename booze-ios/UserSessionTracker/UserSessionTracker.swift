//
//  UserSessionTracker.swift
//  booze-ios
//
//  Created by Владислав Марков on 20/10/2018.
//  Copyright © 2018 Владислав Марков. All rights reserved.
//

import UIKit

class UserSessionTracker {
    static let shared = UserSessionTracker()
    
    private static let userDefaultsTokenName = "token"
    
    var token: String {
        get {
            let token = UserDefaults().object(forKey: UserSessionTracker.userDefaultsTokenName) as? String
            return token ?? ""
        }
        
        set(newToken) {
            UserDefaults().setValue(newToken, forKey: UserSessionTracker.userDefaultsTokenName)
        }
    }
    
    var currentUserId: Int {
        get {
            return UserDefaults().integer(forKey: "currentUserId")
        }
        
        set(newCurrentUserId) {
            UserDefaults().set(newCurrentUserId, forKey: "currentUserId")
        }
    }
    
    private init() {

    }
    
    func isAuth() -> Bool {
        let token = UserDefaults().object(forKey: UserSessionTracker.userDefaultsTokenName) as? String
        return !(token?.isEmpty ?? true)
    }
    
    func logout() {
        token = ""
    }
}
