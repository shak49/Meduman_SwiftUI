//
//  User.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 12/21/21.
//

import Foundation


class User: Identifiable, Codable {
    let id: String?
    let firstName: String?
    let lastName: String?
    let displayName: String?
    let email: String?
    let password: String?
    let phoneNumber: String?
    
    init(id: String? = UUID().uuidString, firstName: String? = "", lastName: String? = "", displayName: String? = "", email: String?, password: String? = "", phoneNumber: String? = "") {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.displayName = displayName
        self.email = email
        self.password = password
        self.phoneNumber = phoneNumber
    }
}

extension User: Equatable {
    static public func ==(lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
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
    
    func validPassword() -> Bool {
        guard let password = password else { return false }
        let predicate = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[$@$#!%*?&]).{6,}$")
        return predicate.evaluate(with: password)
    }
    
    func validatePhoneNumber() -> Bool {
        guard let phoneNumber = phoneNumber else { return false }
        let phoneRegex = "\\+?1?\\s?[2-9][0-9]{2}\\s?[2-9][0-9]{2}\\s?[0-9]{4}"
        let phoneCheck = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneCheck.evaluate(with: phoneNumber)
    }
}
