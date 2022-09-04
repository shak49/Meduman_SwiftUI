//
//  SignUpViewModel.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 9/2/22.
//

import Foundation


protocol AuthViewModelProtocol {
    func singUp(firstName: String, lastName: String, email: String, password: String, phoneNumber: String)
    func signIn(email: String, password: String)
}


class AuthViewModel: ObservableObject, AuthViewModelProtocol {
    //MARK: - Properties
    var isIdentified: Bool = false
    
    //MARK: - Functions
    func singUp(firstName: String, lastName: String, email: String, password: String, phoneNumber: String) {
        let user = User(firstName: firstName, lastName: lastName, email: email, password: password, phoneNumber: phoneNumber)
        AuthManager.shared?.signUp(user: user, completion: { (user, error) in
            print("USER: \(user)")
        })
    }
    
    func signIn(email: String, password: String) {
        AuthManager.shared?.signIn(email: email, password: password, completion: { user, error in
            if let error = error {
                print("ERROR: \(error)")
            }
            if let user = user {
                self.isIdentified = true
            }
            print("USER: \(user)")
        })
    }
}
