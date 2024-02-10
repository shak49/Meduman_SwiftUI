//
//  AuthViewModel.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 9/11/22.
//

import Foundation


class AuthViewModel: ObservableObject {
    //MARK: - Properties
    private var authRepo = AuthService()
    private var firestoreRepo = FirestoreService()
    @Published var isAuthenticated: Bool = false

    //MARK: - Functions
    func singUp(firstName: String, lastName: String, email: String, password: String, phoneNumber: String) {
        let user = User(firstName: firstName, lastName: lastName, email: email, password: password, phoneNumber: phoneNumber)
        authRepo.signUp(user: user) { (user, error) in
            if let error = error {
                print("ERROR: \(error)!")
                return
            }
            self.isAuthenticated = true
        }
        self.createUserProfile(user: user)
    }
    
    func signIn(email: String, password: String) {
        authRepo.signIn(email: email, password: password) { user, error in
            if let error = error {
                print("Error: \(error)")
            }
            self.isAuthenticated = true
        }
    }
    
    func signOut() {
        
    }
    
    func createUserProfile(user: User?) {
        let user = User(id: user?.id, firstName: user?.firstName, lastName: user?.lastName, email: user?.email, password: "Confidential", phoneNumber: user?.phoneNumber)
        firestoreRepo.createUserProfile(user: user) { user, error in
            print("Create Profile Error: \(error)!")
            print("Profile User: \(user?.email)!")
        }
    }
}
