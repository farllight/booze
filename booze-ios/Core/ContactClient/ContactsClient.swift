//
//  ContactsClient.swift
//  booze-ios
//
//  Created by Владислав Марков on 20/10/2018.
//  Copyright © 2018 Владислав Марков. All rights reserved.
//

import Foundation
import ContactsUI

class ContactsClient {
    static let shared = ContactsClient()
    
    private init() {
        
    }
    
    func getAllContactList() -> [Contact] {
        let contactStore = CNContactStore()
        var contacts = [CNContact]()
        let keys =  [
            CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
            CNContactPhoneNumbersKey,
            CNContainerNameKey,
        ] as [Any]
        let request = CNContactFetchRequest(keysToFetch: keys as! [CNKeyDescriptor])
        
        do {
            try contactStore.enumerateContacts(with: request) { (contact, stop) in
                contacts.append(contact)
            }
        }
        catch {
            print("unable to fetch contacts")
        }
        
        var transformedContacts = [Contact]()
        for contact in contacts { 
            transformedContacts.append(contact.toCustomContact())
        }
        
        return transformedContacts
    }
}
