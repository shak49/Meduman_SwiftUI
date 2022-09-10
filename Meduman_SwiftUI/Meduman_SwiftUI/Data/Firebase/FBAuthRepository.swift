//
//  FBAuthRepo.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 9/8/22.
//

import UIKit
import FirebaseAuth


protocol FBAuthProtocol {
    // SHAK: Properties
    var auth: Auth? { get }
    //var user: User? { get }
    
    // SHAK: Functions
    func signUp(user: User?)
    func signIn(email: String?, password: String?)
    func signOut()
}

class FBAuthRepository: FBAuthProtocol {
    //MARK: - Properties
    var firestoreRepo = FBFirestoreRepository()
    var auth: Auth?
    //var user: User?
    
    //MARK: - Lifecycles
    
    //MARK: - Functions
    func signUp(user: User?) {
        guard let user = user else { return }
        self.auth?.createUser(withEmail: user.email ?? "", password: user.password ?? "") { [weak self] (result, error) in
            if let error = error {
                print("Error: \(error)")
                return
            }
        }
    }
    
    func signIn(email: String?, password: String?) {
        guard let email = email, let password = password else { return }
        self.auth?.signIn(withEmail: email, password: password) { [weak self] (result, error) in
            if let error = error {
                print("Error signing in: (error)")
                return
            }
            print("RESULT: \(result?.user)")
        }
    }
    
    func signOut() {
        do {
            try self.auth?.signOut()
            //self.user = nil
        } catch let signOutError as NSError {
            print("Error signning-out: \(signOutError)")
        }
    }
    
}
