//
//  FirebaseProtocol.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 12/22/21.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore


protocol FirebaseAuth {
    // SHAK: Properties
    var auth: Auth { get }
    var user: User? { get }
    typealias CompletionHandler = (User?, DatabaseError?) -> Void
    
    // SHAK: Functions
    func signUp(firstName: String?, lastName: String?, email: String?, password: String?, phoneNumber: String?, completion: @escaping CompletionHandler)
    func singIn(email: String?, password: String?, completion: @escaping CompletionHandler)
    func singOut()
}

protocol FirebaseFirestore {
    // SHAK: Properties
    var db: Firestore { get }
    typealias CompletionHandler = (User?, DatabaseError?) -> Void
    
    // SHAK: Functions
    func createUserProfile(user: User?, completion: @escaping CompletionHandler)
    func fetchUserProfile(userUID: String?, completion: @escaping CompletionHandler)
}
