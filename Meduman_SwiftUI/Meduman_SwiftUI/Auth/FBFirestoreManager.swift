//
//  FBFirestoreManager.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 12/22/21.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


protocol FirebaseFirestore {
    // SHAK: Properties
    var db: Firestore { get }
    typealias CompletionHandler = (User?, DatabaseError?) -> Void
    
    // SHAK: Functions
    func createUserProfile(user: User?, completion: @escaping CompletionHandler)
    func fetchUserProfile(userUID: String?, completion: @escaping CompletionHandler)
}

class FBFirestoreManager: FirebaseFirestore {
    // SHAK: Properties
    var db = Firestore.firestore()
    
    // SHAK: Functions
    func createUserProfile(user: User?, completion: @escaping CompletionHandler) {
        guard let uid = user?.uid else { return }
        do {
            try db.collection("User").document(uid).setData(from: user)
            completion(user, .unableToCreate)
        } catch let error {
            print("Error writing user to Firestore: \(error)")
            completion(nil, error as? DatabaseError)
        }
    }
    
    func fetchUserProfile(userUID: String?, completion: @escaping CompletionHandler) {
        guard let userUID = userUID else { return }
        db.collection("User").document(userUID).getDocument { [weak self] (snapshot, error) in
            let userProfile = try? snapshot?.data(as: User.self)
            completion(userProfile, .noData)
        }
    }
}
