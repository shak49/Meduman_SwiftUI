//
//  User.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 12/21/21.
//

import Foundation


class User: Identifiable, Codable {
    let uid: String
    let firstName: String?
    let lastName: String?
    let email: String?
    let phoneNumber: String?
    
    init(uid: String = "", firstName: String? = "", lastName: String? = "", email: String? = "", phoneNumber: String? = "") {
        self.uid = uid
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phoneNumber = phoneNumber
    }
}

extension User: Equatable {
    static public func ==(lhs: User, rhs: User) -> Bool {
        return lhs.uid == rhs.uid
    }
}

extension User {
    func validateFirstName() -> Bool {
        guard let firstName = firstName else { return false }
        return firstName.count > 3
    }
    
    func validateLastName() -> Bool {
        guard let lastName = lastName else { return false }
        return lastName.count > 3
    }
    
    func validateEmail() -> Bool {
        guard let email = email else { return false }
        return email.contains("@") && email.contains(".")
    }
    
    func validatePhoneNumber() -> Bool {
        guard let phoneNumber = phoneNumber else { return false }
        let phoneRegex = "\\+?1?\\s?[2-9][0-9]{2}\\s?[2-9][0-9]{2}\\s?[0-9]{4}"
        let phoneCheck = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneCheck.evaluate(with: phoneNumber)
    }
}
