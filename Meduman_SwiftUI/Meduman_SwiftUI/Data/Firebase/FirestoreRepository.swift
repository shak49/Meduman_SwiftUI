//
//  FBFirestoreRepo.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 9/8/22.
//

import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift


protocol FirestoreProtocol {
    // SHAK: Properties
    var firestore: Firestore { get }
    typealias CompletionHandler = (User?, AuthError?) -> Void
    
    // SHAK: Functions
    func createUserProfile(user: User?, completion: @escaping CompletionHandler)
    func fetchUserProfile(userId: String?, completion: @escaping CompletionHandler)
}


class FirestoreRepository: FirestoreProtocol {
    //MARK: - Properties
    var firestore = Firestore.firestore()
    
    //MARK: - Lifecycles
    
    //MARK: - Functions
    func createUserProfile(user: User?, completion: @escaping CompletionHandler) {
        guard let user = user else { return }
        do {
            try firestore.collection("user").document(user.id ?? "").setData(from: user)
            completion(user, .unableToCreateUser)
        } catch let error {
            print("Error writing user to Firestore: \(error)")
            completion(nil, error as? AuthError)
        }
    }
    
    func fetchUserProfile(userId: String?, completion: @escaping CompletionHandler) {
        guard let userId = userId else { return }
        firestore.collection("User").document(userId).getDocument { [weak self] (snapshot, error) in
            let userProfile = try? snapshot?.data(as: User.self)
            completion(userProfile, .noUser)
        }
    }
}
