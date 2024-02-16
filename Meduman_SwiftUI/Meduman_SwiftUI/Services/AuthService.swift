//
//  FBAuthRepo.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 9/8/22.
//

import UIKit
import FirebaseAuth


protocol AuthProtocol {
    // SHAK: Functions
    func signUp(user: User?, completion: @escaping(FirebaseAuth.User?, AuthError?) -> Void)
    func signIn(email: String?, password: String?, completion: @escaping(FirebaseAuth.User?, AuthError?) -> Void)
    func signOut()
}


class AuthService: AuthProtocol {
    //MARK: - Properties
    private var user: User?
    private var auth: Auth? = Auth.auth()
    
    //MARK: - Functions
    func signUp(user: User?, completion: @escaping(FirebaseAuth.User?, AuthError?) -> Void) {
        guard let email = user?.email, let password = user?.password else { return }
        auth?.createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("Error: \(error)")
                completion(nil, .unableToCreateUser)
                return
            }
            completion(result?.user, nil)
        }
    }
    
    func signIn(email: String?, password: String?, completion: @escaping(FirebaseAuth.User?, AuthError?) -> Void) {
        guard let email = email, let password = password else { return }
        auth?.signIn(withEmail: email, password: password) { [weak self] (result, error) in
            if let error = error {
                completion(nil, .noUser)
                return
            }
            guard let result = result else { return }
            completion(result.user, nil)
        }
    }
    
    func signOut() {
        do {
            try auth?.signOut()
            self.user = nil
        } catch let signOutError as NSError {
            print("Error signning-out: \(signOutError)")
        }
    }
    
}
