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
        APIClient.shared.registration(phone: phone) { (data, error)  in
            if error == nil {
                completion(true)
            } else {
                completion(false)
            }
            
        }
    }
    
    func login(phone: String, password: String, completion: @escaping IsSuccessCompletion) {
        APIClient.shared.login(phone: phone, password: password) { (data, error) in
            if error != nil {
                completion(false)
                return
            }
            
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
        APIClient.shared.getUser(userId: currentUserId) { (data, error) in
            if error != nil {
                completion(nil)
                return
            }
            
            do {
                let user = try JSONDecoder().decode(User.self, from: data)
                completion(user)
            } catch {
                print(error)
                completion(nil)
            }
        }
    }
    
    func setParty(party: PartyRequestModel, completion: @escaping IsSuccessCompletion) {
        APIClient.shared.setParty(party: party) { (data, error) in
            if error == nil {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    func getAllParties(completion: @escaping ([Party]?) -> Void) {
        APIClient.shared.getAllParties { (data, error) in
            if error != nil {
                completion(nil)
                return
            }
            
            do {
                let parties = try JSONDecoder().decode([Party].self, from: data)
                completion(parties)
            } catch {
                print(error)
                completion(nil)
            }
        }
    }
    
    func getParty(partyId: String, completion: @escaping (Party?) -> Void) {
        APIClient.shared.getParty(partyId: partyId) { (data, error) in
            if error != nil {
                completion(nil)
                return
            }
            
            do {
                let party = try JSONDecoder().decode(Party.self, from: data)
                completion(party)
            } catch {
                print(error)
                completion(nil)
            }
        }
    }
    
    func updateParty(partyId: String, party: Party, completion: @escaping (Party?) -> Void) {
        APIClient.shared.updateParty(partyId: partyId, party: party) { (data, error) in
            if error != nil {
                completion(nil)
                return
            }
            
            do {
                let party = try JSONDecoder().decode(Party.self, from: data)
                completion(party)
            } catch {
                print(error)
                completion(nil)
            }
        }
    }
    
    func getAppUsers(completion: @escaping ([Party]?) -> Void) {
        APIClient.shared.getAllUsers { (data, error) in
            if error != nil {
                completion(nil)
                return
            }
            
            do {
                let patients = try JSONDecoder().decode([Party].self, from: data)
                completion(patients)
            } catch { 
                print(error)
                completion(nil)
            }
        }
    }
    
    func getAllTransactions(completion: @escaping ([Transaction]?) -> Void ) {
        APIClient.shared.getAllParties { (data, error) in
            if error != nil {
                completion(nil)
                return
            }
            
            do {
                let transactions = try JSONDecoder().decode([Transaction].self, from: data)
                completion(transactions)
            } catch {
                print(error)
                completion(nil)
            }
        }
    }
    
    func getTransaction(id: String, completion: @escaping (Transaction?) -> Void) {
        APIClient.shared.getTransaction(id: id) { (data, error) in
            if error != nil {
                completion(nil)
                return
            }
            
            do {
                let transaction = try JSONDecoder().decode(Transaction.self, from: data)
                completion(transaction)
            } catch {
                print(error)
                completion(nil)
            }
        }
    }
    
    func setTransaction(transaction: Transaction, completion: @escaping IsSuccessCompletion) {
        APIClient.shared.setTransaction(transaction: transaction) { (data, error) in
            if error != nil {
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
    func updateTransaction(id: String, transaction: Transaction, completion: @escaping (Transaction?) -> Void) {
        APIClient.shared.updateTransaction(id: id, transaction: transaction) { (data, error) in
            if (error != nil) {
                completion(nil)
            }
            
            do {
                let tranasactiin = try JSONDecoder().decode(Transaction.self, from: data) 
                completion(tranasactiin)
            } catch {
                print(error)
                completion(nil)
            }
        }
    }
}
