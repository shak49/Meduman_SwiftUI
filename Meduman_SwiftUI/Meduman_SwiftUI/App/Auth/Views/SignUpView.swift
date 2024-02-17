//
//  SignUpView.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 1/5/22.
//

import SwiftUI

struct SignUpView: View {
    // SHAK: Properties
    @ObservedObject private var vm = AuthViewModel()
    
    //MARK: - Body
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    TextField("First name...", text: $vm.firstName)
                        .frame(width: 350, height: 50)
                    Divider()
                }
                VStack {
                    TextField("Last name...", text: $vm.lastName)
                        .frame(width: 350, height: 50)
                    Divider()
                }
                VStack {
                    TextField("Email...", text: $vm.email)
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
                VStack {
                    HStack {
                        Button {
                            
                        } label: {
                            Text("+1")
                                .foregroundColor(.gray)
                        }
                        .frame(width: 25, height: 25)
                        .padding()
                        TextField("Phone number...", text: $vm.phoneNumber)
                            .frame(width: 350, height: 50)
                            .keyboardType(.numberPad)
                    }
                    .padding(.leading, 25)
                    Divider()
                }
                Button {
                    vm.singUp(firstName: vm.firstName, lastName: vm.lastName, email: vm.email, password: vm.password, phoneNumber: vm.phoneNumber)
                } label: {
                    Text("Sign Up")
                }
                .frame(width: 350, height: 50)
                .background(.black)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding()
                .fullScreenCover(isPresented: $vm.isAuthenticated, content: TabContainerView.init)
                Divider()
            }
            .padding(.top, 50)
            Spacer()
            .navigationTitle("Sign Up")
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
