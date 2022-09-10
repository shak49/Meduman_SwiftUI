//
//  UserManager.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 9/9/22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore


protocol UserAuthProtocol {
    //MARK: - Properties
    var user: User? { get }
    
    //MARK: - Functions
    func signUp(user: User?, completion: @escaping(User?, DatabaseError) -> Void)
    func signIn(email: String?, password: String?, completion: @escaping(FirebaseAuth.User?, DatabaseError) -> Void)
    func SignOut()
    func createProfile(user: User?)
}


class UserManager: UserAuthProtocol {
    //MARK: - Properties
    var authRepo: FBAuthProtocol
    var firestorRepo: FBFirestoreProtocol
    var user: User?
    
    //MARK: - Lifecycles
    init(authRepo: FBAuthProtocol, firestoreRepo: FBFirestoreProtocol) {
        self.authRepo = authRepo
        self.firestorRepo = firestoreRepo
    }
    
    //MARK: - Functions
    func signUp(user: User?, completion: @escaping(User?, DatabaseError) -> Void) {
        self.authRepo.signUp(user: user) { user, error in
            if error != nil {
                print("Sign Up Error: \(error)!")
            }
            completion(user, error as! DatabaseError)
            self.createProfile(user: user)
        }
    }
    
    func signIn(email: String?, password: String?, completion: @escaping(FirebaseAuth.User?, DatabaseError) -> Void) {
        self.authRepo.signIn(email: email, password: password) { user, error in
            if error != nil {
                print("Error: \(error)")
            }
            completion(user, error as! DatabaseError)
        }
    }
    
    func SignOut() {
        self.authRepo.signOut()
    }
    
    func createProfile(user: User?) {
        let user = User(id: user?.id, firstName: user?.firstName, lastName: user?.lastName, email: user?.email, password: "Confidential", phoneNumber: user?.phoneNumber)
        self.firestorRepo.createUserProfile(user: user) { user, error in
            print("Create Profile Error: \(error)!")
            print("Profile User: \(user)!")
        }
    }
}
