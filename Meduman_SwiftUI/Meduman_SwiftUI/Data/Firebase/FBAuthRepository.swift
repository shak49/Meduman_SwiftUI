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
    func signUp(user: User?, completion: @escaping(FirebaseAuth.User?, DatabaseError?) -> Void)
    func signIn(email: String?, password: String?, completion: @escaping(FirebaseAuth.User?, DatabaseError?) -> Void)
    func signOut()
}

class FBAuthRepository: FBAuthProtocol {
    //MARK: - Properties
    var auth: Auth? = Auth.auth()
    var user: User?
    
    //MARK: - Lifecycles
    
    //MARK: - Functions
    func signUp(user: User?, completion: @escaping(FirebaseAuth.User?, DatabaseError?) -> Void) {
        guard let email = user?.email, let password = user?.password else { return }
        auth?.createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("Error: \(error)")
                completion(nil, .unableToCreate)
                return
            }
            completion(result?.user, nil)
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
            guard let result = result else { return }
            print("RESULT: \(result.user.uid)")
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
