//
//  BaseVM.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 2/17/24.
//

import Foundation


class BaseVM: ObservableObject {
    //MARK: - Properties
    var authService = AuthService()
    var firestoreService = FirestoreService()
    var username: String = ""
    
    //MARK: - Lifecycles
    init() {
        getUsername()
    }
    
    //MARK: - Functions
    private func getUsername() {
        Task {
            guard let username = try await authService.getCurrentUser().displayName else { return }
            self.username = username
        }
    }
}
