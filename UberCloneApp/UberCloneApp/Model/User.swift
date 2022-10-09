//
//  User.swift
//  UberCloneApp
//
//  Created by Намик on 10/9/22.
//

import CoreLocation

enum AccountType: Int {
    case passenger
    case driver
}

struct User {

    let fullname: String
    let email: String
    var accountType: AccountType!
    var location: CLLocation?
//    let uid: String
    
    init(dictionary: [String: Any]) {
        fullname = dictionary["fullname"] as? String ?? ""
        email = dictionary["email"] as? String ?? ""
        
        if let index = dictionary["accountType"] as? Int {
            accountType = AccountType(rawValue: index)
        }
    }
}
