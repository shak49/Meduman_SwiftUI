//
//  FBAuthManager.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 12/22/21.
//

import Foundation
import FirebaseAuth


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
            self?.firebaseFirestoreManager.shared?.createUserProfile(user: user, completion: { [weak self] (user, error) in
                
            })
        }
    }
    
    func singIn(email: String?, password: String?, completion: @escaping CompletionHandler) {
        
    }
    
    func singOut() {
        
    }
}
