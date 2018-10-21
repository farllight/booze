//
//  APIClient.swift
//  booze-ios
//
//  Created by Владислав Марков on 19/10/2018.
//  Copyright © 2018 Владислав Марков. All rights reserved.
//

import UIKit
import Alamofire

typealias Completion = (Data, Error?) -> Void

class APIClient {
    static let shared = APIClient()
    
    private let baseUrl = "http://beta-secothon.profsoft.online/api/"
    private let authToken = UserSessionTracker.shared.token
    
    private init() {
        
    }
    
    private func baseRequest(path: String, method: HTTPMethod, params: Parameters?, headers: HTTPHeaders, completion: @escaping Completion) {
        Alamofire.request(baseUrl + path, method: method, parameters: params, encoding: JSONEncoding(), headers: headers).responseJSON { (data) in
            
            let statusCode = data.response?.statusCode
            if statusCode == 200 {
                completion(data.data ?? Data(), nil)
            } else if statusCode == 404 {
                completion(Data(), NSError(domain: "Server Error", code: 404, userInfo: nil))
            } else if statusCode == nil {
                completion(Data(), NSError(domain: "Internet Error", code: -1009, userInfo: nil))
            } else {
                completion(Data(), NSError(domain: "Unknown Error", code: statusCode ?? 1, userInfo: nil))
            }
        }
    }

    func registration(phone: String, completion: @escaping Completion) {
        let params = [
            "phone": phone,
            "platform": "iOS",
            "version": "1.0",
            "name": "far__light"
        ]
        baseRequest(path: "registration", method: .post, params: params, headers: ["Content-Type" : "application/json"], completion: completion)
    }
    
    func login(phone: String, password: String, completion: @escaping Completion) {
        let params = [
            "phone": phone,
            "password": password,
            "platform": "iOS",
            "version": "1.0",
            "name": "far__light"
        ]
        baseRequest(path: "login", method: .post, params: params, headers: ["Content-Type" : "application/json"], completion: completion)
    }
    
    func getUser(userId: Int, completion: @escaping Completion) {
        baseRequest(path: "user/\(userId)", method: .get, params: nil, headers: ["apikey": authToken], completion: completion)
    }
    
    func setParty(party: PartyRequestModel, completion: @escaping Completion) {
        baseRequest(path: "party/", method: .post, params: party.toDictionary(), headers: ["Content-Type" : "application/json", "apikey": authToken], completion: completion)
    }
    
    func getAllParties(completion: @escaping Completion) {
        baseRequest(path: "party/", method: .get, params: nil, headers: ["apikey": authToken], completion: completion)
    }
    
    func getParty(partyId: String, completion: @escaping Completion) {
        baseRequest(path: "party/\(partyId)", method: .get, params: nil, headers: ["apikey": authToken], completion: completion)
    }
    
    func updateParty(partyId: String, party: Party, completion: @escaping Completion) {
        let params: [String: Any] = [
            "id": partyId,
            "name": party.name,
            "date": party.date,
            "users": party.users.map({ $0.toDictionary() })
        ]
        baseRequest(path: "party/", method: .patch, params: params, headers: ["Content-Type":"application/json", "apiKey": authToken], completion: completion)
    }
    
    func getAllUsers(completion: @escaping Completion) {
        baseRequest(path: "user/", method: .get, params: nil, headers: ["apikey": authToken], completion: completion)
    }
    
    func getAllTransactions(completion: @escaping Completion) {
        baseRequest(path: "transaction/", method: .get, params: nil, headers: ["apikey": authToken], completion: completion)
    }
    
    func getTransaction(id: String, completion: @escaping Completion) {
        baseRequest(path: "transaction/\(id)", method: .get, params: nil, headers: ["Content-Type": "application/json"], completion: completion)
    }
    
    func setTransaction(transaction: Transaction, completion: @escaping Completion) {
        baseRequest(path: "transaction/", method: .post, params: transaction.toDictionaryForRequest(), headers: ["Content-Type": "application/json", "apikey": authToken], completion: completion)
    }
    
    func updateTransaction(id: String, transaction: Transaction, completion: @escaping Completion) {
        let params = transaction.toDictionaryForRequest()  
        baseRequest(path: "transaction/", method: .patch, params: params, headers: ["Content-Type": "application/json", ], completion: completion)
    }
}
