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
    var accountType: Int
    var location: CLLocation?
    let uid: String
    
    init(uid: String, dictionary: [String: Any]) {
        self.uid = uid
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.accountType = dictionary["accountType"] as? Int ?? 0
    }
}
