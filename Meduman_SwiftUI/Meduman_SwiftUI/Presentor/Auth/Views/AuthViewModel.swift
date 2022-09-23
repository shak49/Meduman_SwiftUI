//
//  AuthViewModel.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 9/11/22.
//

import Foundation


protocol AuthViewModelProtocol {
    func singUp(firstName: String, lastName: String, email: String, password: String, phoneNumber: String)
    func signIn(email: String, password: String)
}


class AuthViewModel: ObservableObject, AuthViewModelProtocol {
    //MARK: - Properties
    var userManger: UserManager
    @Published var isAuthenticated: Bool = false
    
    //MARK: - Lifecycles
    init(userManager: UserManager) {
        self.userManger = userManager
    }
    
    //MARK: - Functions
    func singUp(firstName: String, lastName: String, email: String, password: String, phoneNumber: String) {
        let user = User(firstName: firstName, lastName: lastName, email: email, password: password, phoneNumber: phoneNumber)
        userManger.signUp(user: user, completion: { (user, error) in
            if let error = error {
                print("VM ERROR: \(error)!")
                return
            }
            if let user = user {
                self.isAuthenticated = true
                print("VM USER: \(user)!")
            }
        })
    }
    
    func signIn(email: String, password: String) {
        userManger.signIn(email: email, password: password, completion: { user, error in
            if let error = error {
                print("ERROR: \(error)")
            }
            if let user = user {
                self.isAuthenticated = true
                print("USER: \(user)")
            }
        })
    }
    
    func signOut() {
        
    }
}
