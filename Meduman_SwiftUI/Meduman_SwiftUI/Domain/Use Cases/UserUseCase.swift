//
//  UserManager.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 9/9/22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore


protocol UserUseCaseProtocol {
    //MARK: - Properties
    var user: User? { get }
    
    //MARK: - Functions
    func signUp(user: User?, completion: @escaping(FirebaseAuth.User?, AuthError?) -> Void)
    func signIn(email: String?, password: String?, completion: @escaping(FirebaseAuth.User?, AuthError?) -> Void)
    func SignOut()
    func createProfile(user: User?)
}


class UserUseCase: UserUseCaseProtocol {
    //MARK: - Properties
    var authRepo: AuthRepository
    var firestoreRepo: FirestoreRepository
    var user: User?
    
    //MARK: - Lifecycles
    init(authRepo: AuthRepository, firestoreRepo: FirestoreRepository) {
        self.authRepo = authRepo
        self.firestoreRepo = firestoreRepo
    }
    
    //MARK: - Functions
    func signUp(user: User?, completion: @escaping(FirebaseAuth.User?, AuthError?) -> Void) {
        guard let user = user else { return }
        authRepo.signUp(user: user) { (user, error) in
            if let error = error {
                print("ERROR: \(error)!")
                return
            }
            print("USER: \(user)")
            completion(user, error)
        }
        self.createProfile(user: user)
    }
    
    func signIn(email: String?, password: String?, completion: @escaping(FirebaseAuth.User?, AuthError?) -> Void) {
        authRepo.signIn(email: email, password: password) { user, error in
            if let error = error {
                print("Error: \(error)")
            }
            print("USER: \(user?.uid)")
            completion(user, error)
        }
    }
    
    func SignOut() {
        authRepo.signOut()
    }
    
    func createProfile(user: User?) {
        let user = User(id: user?.id, firstName: user?.firstName, lastName: user?.lastName, email: user?.email, password: "Confidential", phoneNumber: user?.phoneNumber)
        firestoreRepo.createUserProfile(user: user) { user, error in
            print("Create Profile Error: \(error)!")
            print("Profile User: \(user?.email)!")
        }
    }
}