//
//  User.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 12/21/21.
//

import Foundation
import FirebaseAuth


struct User: Identifiable {
    let authUser: FirebaseAuth.User?
    let id: String?
    var displayName: String? {
        guard let authUser = authUser else { return nil }
        return authUser.displayName
    }
    var email: String? {
        guard let authUser = authUser else { return nil }
        return authUser.email
    }
    
    init(authUser: FirebaseAuth.User?, id: String? = "") {
        self.authUser = authUser
        self.id = id
    }
}
