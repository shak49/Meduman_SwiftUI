//
//  UserManager.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 9/9/22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore


protocol UserManagerProtocol {
    //MARK: - Properties
    var user: User? { get }
    
    //MARK: - Functions
    func signUp(user: User?, completion: @escaping(User?, DatabaseError?) -> Void)
    func signIn(email: String?, password: String?, completion: @escaping(FirebaseAuth.User?, DatabaseError?) -> Void)
    func SignOut()
    func createProfile(user: User?)
}


class UserManager: UserManagerProtocol {
    //MARK: - Properties
    static let shared = UserManager()
    var authRepo: FBAuthRepository = FBAuthRepository()
    var firestorRepo: FBFirestoreRepository = FBFirestoreRepository()
    var user: User?
    
    //MARK: - Lifecycles
    
    //MARK: - Functions
    func signUp(user: User?, completion: @escaping(User?, DatabaseError?) -> Void) {
        authRepo.signUp(user: user) { user, error in
            if let error = error {
                print("Sign Up Error: \(error)!")
            }
            completion(user, error as? DatabaseError)
            self.createProfile(user: user)
        }
    }
    
    func signIn(email: String?, password: String?, completion: @escaping(FirebaseAuth.User?, DatabaseError?) -> Void) {
        authRepo.signIn(email: email, password: password) { user, error in
            if let error = error {
                print("Error: \(error)")
            }
            print("USER: \(user?.uid)")
            completion(user, error as? DatabaseError)
        }
    }
    
    func SignOut() {
        self.authRepo.signOut()
    }
    
    func createProfile(user: User?) {
        let user = User(id: user?.id, firstName: user?.firstName, lastName: user?.lastName, email: user?.email, password: "Confidential", phoneNumber: user?.phoneNumber)
        firestorRepo.createUserProfile(user: user) { user, error in
            print("Create Profile Error: \(error)!")
            print("Profile User: \(user)!")
        }
    }
}
