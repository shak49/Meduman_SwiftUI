//
//  FBAuthManager.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 12/22/21.
//

import Foundation
import FirebaseAuth


protocol AuthProtocol {
    // SHAK: Properties
    var auth: Auth { get }
    var user: User? { get }
    typealias CompletionHandler = (User?, DatabaseError?) -> Void
    
    // SHAK: Functions
    func signUp(user: User?, completion: @escaping CompletionHandler)
    func signIn(email: String?, password: String?, completion: @escaping CompletionHandler)
    func signOut()
}


class AuthManager: AuthProtocol {
    // SHAK: Properties
    static var shared: AuthManager? = AuthManager()
    var auth = Auth.auth()
    var user: User?
    var firestoreManager = FirestoreManager()
    
    // SHAK: Functions
    func signUp(user: User?, completion: @escaping CompletionHandler) {
        guard let user = user else { return }
        auth.createUser(withEmail: user.email ?? "", password: user.password ?? "") { [weak self] (_, error) in
            if let error = error {
                print("Error: \(error)")
                completion(nil, .unableToCreate)
                return
            }
            let user = User(id: user.id, firstName: user.firstName, lastName: user.lastName, email: user.email, password: user.password, phoneNumber: user.phoneNumber)
            self?.firestoreManager.createUserProfile(user: user, completion: { [weak self] (user, error) in
                if let error = error {
                    print("Error while creating user profile \(error)")
                    completion(nil, error)
                    return
                }
                self?.user = user
                completion(user, nil)
            })
        }
    }
    
    func signIn(email: String?, password: String?, completion: @escaping CompletionHandler) {
        guard let email = email, let password = password else { return }
        auth.signIn(withEmail: email, password: password) { [weak self] (result, error) in
            if let error = error {
                print("Error signing in: (error)")
                completion(nil, .noData)
                return
            }
            guard let user = result?.user else { return }
            print("User \(user.uid) signed in.")
            self?.firestoreManager.fetchUserProfile(userId: user.uid, completion: { [weak self] (user, error) in
                if let error = error {
                    print("Error while fetching the user profile: \(error)")
                    completion(nil, error)
                    return
                }
                self?.user = user
                completion(user, nil)
            })
        }
    }
    
    func signOut() {
        do {
            try auth.signOut()
            self.user = nil
        } catch let signOutError as NSError {
            print("Error signning-out: \(signOutError)")
        }
    }
}
