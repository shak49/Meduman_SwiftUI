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
        firebaseService.initiateSignInWithApple(request: request)
    }
    
    func handleAppleAuthResult(result: Result<ASAuthorization, Error>) {
        Task {
            guard let credential = await firebaseService.getAppleCredential(result: result) else { return }
            switch credential {
            case .success(let user):
                await MainActor.run {
                    guard let username = user?.displayName else { return }
                    self.username = username
                    self.isAuthenticated = true
                }
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    func signInWithGoogle() {
        Task {
            guard let view = await getRootViewController() else { return }
            let credential = await firebaseService.signInWithGoogle(view: view)
            switch credential {
            case .success(let user):
                await MainActor.run {
                    guard let username = user?.displayName else { return }
                    self.username = username
                    self.isAuthenticated = true
                }
            case .failure(let error):
                print(error)
                break
            case .none:
                break
            }
        }
    }
}

extension AuthViewModel {
    func getRootViewController() async -> UIViewController? {
        guard let windowScene = await UIApplication.shared.connectedScenes.first as? UIWindowScene, let window = await windowScene.windows.first, let rootViewController = await window.rootViewController else { return nil }
        return rootViewController
    }
}
