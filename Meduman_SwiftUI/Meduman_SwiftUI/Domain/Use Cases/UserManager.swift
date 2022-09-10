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
    func signUp(user: User?, completion: @escaping(Result<FirebaseAuth.User?, DatabaseError>) -> Void)
    func signIn(email: String?, password: String?, completion: @escaping(Result<User, DatabaseError>) -> Void)
    func SignOut()
    func createProfile(user: User?)
}


class UserManager: UserAuthProtocol {
    //MARK: - Properties
    var authRepo = FBAuthRepository()
    var firestorRepo = FBFirestoreRepository()
    var user: User?
    
    //MARK: - Functions
    func signUp(user: User?, completion: @escaping(Result<FirebaseAuth.User?, DatabaseError>) -> Void) {
        self.authRepo.signUp(user: user)
        createProfile(user: user)
    }
    
    func signIn(email: String?, password: String?, completion: @escaping (Result<User, DatabaseError>) -> Void) {
        self.authRepo.signIn(email: email, password: password)
    }
    
    func SignOut() {
        self.authRepo.signOut()
    }
    
    func createProfile(user: User?) {
        let user = User(id: user?.id, firstName: user?.firstName, lastName: user?.lastName, email: user?.email, password: "Confidential", phoneNumber: user?.phoneNumber)
        self.firestorRepo.createUserProfile(user: user)
    }
}
