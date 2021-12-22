//
//  FBFirestoreManager.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 12/22/21.
//

import Foundation
import FirebaseFirestore


class FBFirestoreManager: FirebaseFirestore {
    // SHAK: Properties
    var shared: FBFirestoreManager? = FBFirestoreManager()
    var db = Firestore.firestore()
    
    // SHAK: Functions
    func createUserProfile(user: User?, completion: @escaping CompletionHandler) {
        
    }
    
    func fetchUserProfile(user: User?, completion: @escaping CompletionHandler) {
        
    }
}
