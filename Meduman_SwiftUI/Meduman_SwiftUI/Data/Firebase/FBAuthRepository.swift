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
    var user: User? { get }
    
    // SHAK: Functions
    func signUp(user: User?, completion: @escaping(User?, DatabaseError?) -> Void)
    func signIn(email: String?, password: String?, completion: @escaping(FirebaseAuth.User?, DatabaseError?) -> Void)
    func signOut()
}

class FBAuthRepository: FBAuthProtocol {
    //MARK: - Properties
    var auth: Auth?
    var user: User?
    
    //MARK: - Lifecycles
    
    //MARK: - Functions
    func signUp(user: User?, completion: @escaping(User?, DatabaseError?) -> Void) {
        guard let user = user else { return }
        auth?.createUser(withEmail: user.email ?? "", password: user.password ?? "") { [weak self] (result, error) in
            if let error = error {
                print("Error: \(error)")
                completion(nil, .unableToCreate)
                return
            }
            completion(user, nil)
        }
    }
    
    func signIn(email: String?, password: String?, completion: @escaping(FirebaseAuth.User?, DatabaseError?) -> Void) {
        guard let email = email, let password = password else { return }
        auth?.signIn(withEmail: email, password: password) { [weak self] (result, error) in
            if let error = error {
                print("Error signing in: \(error)")
                completion(nil, .noData)
                return
            }
            print("RESULT: \(result?.user.uid)")
            completion(result?.user, nil)
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
