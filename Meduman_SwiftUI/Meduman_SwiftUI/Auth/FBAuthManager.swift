//
//  FBAuthManager.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 12/22/21.
//

import Foundation
import FirebaseAuth


protocol FirebaseAuth {
    // SHAK: Properties
    var auth: Auth { get }
    var user: User? { get }
    typealias CompletionHandler = (User?, DatabaseError?) -> Void
    
    // SHAK: Functions
    func signUp(firstName: String?, lastName: String?, email: String?, password: String?, phoneNumber: String?, completion: @escaping CompletionHandler)
    func signIn(email: String?, password: String?, completion: @escaping CompletionHandler)
    func signOut()
}

class FBAuthManager: FirebaseAuth {
    // SHAK: Properties
    static var shared: FBAuthManager? = FBAuthManager()
    var auth = Auth.auth()
    var user: User?
    var firebaseFirestoreManager = FBFirestoreManager()
    
    // SHAK: Functions
    func signUp(firstName: String?, lastName: String?, email: String?, password: String?, phoneNumber: String?, completion: @escaping CompletionHandler) {
        guard let email = email, let password = password else { return }
        auth.createUser(withEmail: email, password: password) { [weak self] (result, error) in
            if let error = error {
                print("Error: \(error)")
                completion(nil, .unableToCreate)
                return
            }
            guard let userResult = result?.user else { return }
            print("User \(userResult.uid) signed up.")
            let user = User(uid: userResult.uid, firstName: firstName, lastName: lastName, email: email, phoneNumber: phoneNumber)
            self?.firebaseFirestoreManager.createUserProfile(user: user, completion: { [weak self] (user, error) in
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
            self?.firebaseFirestoreManager.fetchUserProfile(userUID: user.uid, completion: { [weak self] (user, error) in
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
