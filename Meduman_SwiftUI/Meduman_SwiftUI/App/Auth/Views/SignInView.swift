//
//  SignInView.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 12/28/21.
//

import SwiftUI


struct SignInView: View {
    //MARK: - Properties
    @ObservedObject private var vm = AuthViewModel()
    
    //MARK: - Body
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    TextField("Enter your email...", text: $vm.email)
                        .frame(width: 350, height: 50)
                        .autocapitalization(.none)
                    Divider()
                }
                VStack {
                    HStack {
                        if vm.isVisible {
                            TextField("Enter your password...", text: $vm.password)
                                .frame(width: 350, height: 50)
                                .autocapitalization(.none)
                        } else {
                            SecureField("Enter your password...", text: $vm.password)
                                .frame(width: 350, height: 50)
                                .autocapitalization(.none)
                        }
                    }
                    .overlay(alignment: .trailing) {
                        Image(systemName: vm.isVisible ? "eye" : "eye.slash")
                            .foregroundColor(.gray)
                            .onTapGesture {
                                vm.isVisible.toggle()
                            }
                    }
                    Divider()
                }
                .padding()
                Button {
                    vm.signIn(email: vm.email, password: vm.password)
                } label: {
                    Text("Sign In")
                        .foregroundColor(.white)
                }
                .frame(width: 350, height: 50)
                .background(.black)
                .cornerRadius(10)
                .padding(.top, 50)
                .fullScreenCover(isPresented: $vm.isAuthenticated, content: TabContainerView.init)
                Divider()
                    .padding(.top, 25)
                VStack {
                    Button {
                        
                    } label: {
                        Text("Forgot your password?")
                            .foregroundColor(.gray)
                    }
                    Button {
                        vm.isPresented.toggle()
                    } label: {
                        Text("Create a new account.")
                            .foregroundColor(.gray)
                    }
                    .popover(isPresented: $vm.isPresented, content: {
                        SignUpView()
                    })
                    .padding()
                }
                .padding(.top, 35)
            }
            .padding(.top)
                .navigationTitle("Sign In")
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
