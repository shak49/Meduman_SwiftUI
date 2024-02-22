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
    var username: String = ""
    
    //MARK: - Lifecycles
    init() {
        getUserInfo()
    }
    
    //MARK: - Functions
    private func getUserInfo() {
        Task {
            guard let username = try await firebaseService.getCurrentUser().displayName else { return }
            self.username = username
        }
    }
}
