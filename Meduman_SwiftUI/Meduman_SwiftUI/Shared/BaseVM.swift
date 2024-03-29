//
//  BaseVM.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 2/17/24.
//

import SwiftUI

class BaseVM: ObservableObject {
    //MARK: - Properties
    var firebaseService = FirebaseService()
    @AppStorage("age") var age: String = ""
    @AppStorage("sex") var sex: String = ""
    @Published var user: User?
    
    //MARK: - Lifecycles
    init() {
        getUserInfo()
    }
    
    //MARK: - Functions
    func getUserInfo() {
        Task {
            let user = try await firebaseService.getCurrentUser()
            self.user = User(authUser: user)
        }
    }
}
