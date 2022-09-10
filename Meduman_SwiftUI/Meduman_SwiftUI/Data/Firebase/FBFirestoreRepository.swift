//
//  FBFirestoreRepo.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 9/8/22.
//

import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift


protocol FBFirestoreProtocol {
    // SHAK: Properties
    var firestore: Firestore { get }
    
    // SHAK: Functions
    func createUserProfile(user: User?)
    func fetchUserProfile(userId: String?)
}

class FBFirestoreRepository: FBFirestoreProtocol {
    //MARK: - Properties
    var firestore = Firestore.firestore()
    
    //MARK: - Lifecycles
    
    //MARK: - Functions
    func createUserProfile(user: User?) {
        guard let user = user else { return }
        do {
            try firestore.collection("user").document(user.id ?? "").setData(from: user)
        } catch let error {
            print("Error writing user to Firestore: \(error)")
        }
    }
    
    func fetchUserProfile(userId: String?) {
        guard let userId = userId else { return }
        firestore.collection("User").document(userId).getDocument { [weak self] (snapshot, error) in
            let userProfile = try? snapshot?.data(as: User.self)
        }
    }
}
