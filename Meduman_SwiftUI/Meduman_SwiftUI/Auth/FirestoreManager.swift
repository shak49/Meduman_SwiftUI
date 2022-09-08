//
//  FBFirestoreManager.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 12/22/21.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


protocol FirestoreProtocol {
    // SHAK: Properties
    var db: Firestore { get }
    typealias CompletionHandler = (User?, DatabaseError?) -> Void
    
    // SHAK: Functions
    func createUserProfile(user: User?, completion: @escaping CompletionHandler)
    func fetchUserProfile(userId: String?, completion: @escaping CompletionHandler)
}


class FirestoreManager: FirestoreProtocol {
    // SHAK: Properties
    var db = Firestore.firestore()
    
    // SHAK: Functions
    func createUserProfile(user: User?, completion: @escaping CompletionHandler) {
        guard let user = user else { return }
        do {
            try db.collection("user").document(user.id ?? "").setData(from: user)
            completion(user, .unableToCreate)
        } catch let error {
            print("Error writing user to Firestore: \(error)")
            completion(nil, error as? DatabaseError)
        }
    }
    
    func fetchUserProfile(userId: String?, completion: @escaping CompletionHandler) {
        guard let userId = userId else { return }
        db.collection("User").document(userId).getDocument { [weak self] (snapshot, error) in
            let userProfile = try? snapshot?.data(as: User.self)
            completion(userProfile, .noData)
        }
    }
}
