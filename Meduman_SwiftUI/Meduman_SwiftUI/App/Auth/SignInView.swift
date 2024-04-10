//
//  SignInView.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 12/28/21.
//

import SwiftUI
import AuthenticationServices


struct SignInView: View {
    //MARK: - Properties
    @EnvironmentObject var navigator: Navigator
    @Environment(\.colorScheme) var colorScheme
    @StateObject var vm = AuthViewModel()
    
    //MARK: - Body
    var body: some View {
        NavigationView {
            VStack(spacing: 100) {
                Circle()
                    .frame(width: 300, height: 300)
                    .foregroundColor(.cyan)
                    .overlay {
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 150, height: 150)
                            .foregroundColor(.placeholder)
                    }
                VStack(spacing: 20) {
                    // Apple Sign In
                    SignInWithAppleButton(.continue) { request in
                        vm.requestAuthWithApple(request: request)
                    } onCompletion: { result in
                        vm.handleAppleAuthResult(result: result) {
                            navigator.push(to: .tabContainer)
                        }
                    }
                    .frame(height: 50)
                    .cornerRadius(10)
                    // Google Sign In
                    GoogleAuthButton {
                        vm.signInWithGoogle {
                            navigator.push(to: .tabContainer)
                        }
                    }
                    // Facebook Sign In
                }
                .padding(.horizontal, 32)
            }
            .navigationTitle("Sign In")
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
