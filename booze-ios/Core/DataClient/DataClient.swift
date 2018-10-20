//
//  DataClient.swift
//  booze-ios
//
//  Created by Владислав Марков on 20/10/2018.
//  Copyright © 2018 Владислав Марков. All rights reserved.
//

import UIKit

class DataClient {
    typealias IsSuccessCompletion = (Bool) -> Void
    
    static let shared = DataClient()
    
    private init() {
        
    }
    
    func registration(phone: String, completion: @escaping IsSuccessCompletion) {
        APIClient.shared.registration(phone: phone) { (data) in
            completion(true)
        }
    }
    
    func login(phone: String, password: String, completion: @escaping IsSuccessCompletion) {
        APIClient.shared.login(phone: phone, password: password) { (data) in
            do {
                let registrationResponseModel = try JSONDecoder().decode(RegistrationResponseModel.self, from: data)
                UserSessionTracker.shared.token = registrationResponseModel.token
                UserSessionTracker.shared.currentUserId = registrationResponseModel.user.id
                completion(true)
            } catch {
                print(error)
                completion(false)
            }
        }
    }
    
    func getUser(currentUserId: Int, completion: @escaping (User?) -> Void) {
        APIClient.shared.getUser(userId: currentUserId) { (data) in
            do {
                let user = try JSONDecoder().decode(User.self, from: data)
                completion(user)
            } catch {
                print(error)
                completion(nil)
            }
        }
    }
    
    func setParty(party: Party, completion: @escaping IsSuccessCompletion) {
        APIClient.shared.setParty(party: party) { (data) in
            completion(true)
        }
    }
}
