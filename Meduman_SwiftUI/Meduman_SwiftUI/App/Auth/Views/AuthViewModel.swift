//
//  AuthViewModel.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 9/11/22.
//

import SwiftUI


class AuthViewModel: CommonVM, ObservableObject {
    //MARK: - Properties
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var phoneNumber: String = ""
    @Published var isPresented: Bool = false
    @Published var isVisible: Bool = false
    @Published var isAuthenticated: Bool = false

    //MARK: - Functions
    func singUp(firstName: String, lastName: String, email: String, password: String, phoneNumber: String) {
        let user = User(firstName: firstName, lastName: lastName, email: email, password: password, phoneNumber: phoneNumber)
        authService.signUp(user: user) { (user, error) in
            if let error = error {
                print("ERROR: \(error)!")
                return
            } else {
                self.isAuthenticated = true
            }
        }
        self.createUserProfile(user: user)
    }
    
    func signIn(email: String, password: String) {
        authService.signIn(email: email, password: password) { user, error in
            if let error = error {
                print("Error: \(error)")
            } else {
                self.isAuthenticated = true
            }
        }
    }
    
    func createUserProfile(user: User?) {
        let user = User(id: user?.id, firstName: user?.firstName, lastName: user?.lastName, email: user?.email, password: "Confidential", phoneNumber: user?.phoneNumber)
        firestoreService.createUserProfile(user: user) { user, error in
            print("Create Profile Error: \(error)!")
            print("Profile User: \(user?.email)!")
        }
    }
}
