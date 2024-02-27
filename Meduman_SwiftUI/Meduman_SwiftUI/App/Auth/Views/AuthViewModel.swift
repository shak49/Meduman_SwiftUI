//
//  AuthViewModel.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 9/11/22.
//

import SwiftUI
import CryptoKit
import FirebaseAuth
import AuthenticationServices


class AuthViewModel: BaseVM {
    //MARK: - Properties
    @Published var isAuthenticated: Bool = false

    //MARK: - Functions
    func requestAuthWithApple(request: ASAuthorizationAppleIDRequest) {
        firebaseService.initiateSignInWithAppleFlow(request: request)
    }
    
    func handleAppleAuthResult(result: Result<ASAuthorization, Error>) {
        Task { @MainActor in
            let result = try await firebaseService.getCredential(result: result)
            guard let username = result?.displayName else { return }
            self.username = username
            self.isAuthenticated = true
        }
    }
}
