//
//  BaseVM.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 2/17/24.
//

import Foundation


class BaseVM: ObservableObject {
    //MARK: - Properties
    var firebaseService = FirebaseService()
    var user: User?
    
    //MARK: - Lifecycles
    init() {
        getUserInfo()
    }
    
    //MARK: - Functions
    private func getUserInfo() {
        Task {
            let user = try await firebaseService.getCurrentUser()
            self.user = User(authUser: user)
        }
    }
}
