//
//  SignUpView.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 1/5/22.
//

import SwiftUI

struct SignUpView: View {
    // SHAK: Properties
    @ObservedObject private var model: AuthViewModel
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var phoneNumber: String = ""
    @State private var isVisible: Bool = false
    
    //MARK: - Lifecycles
    init() {
        self.model = AuthViewModel()
    }
    
    //MARK: - Body
    var body: some View {
        NavigationView {
            ZStack {
                Image("background.jpg")
                    .resizable()
                    .scaledToFill()
                    .opacity(0.50)
                    .ignoresSafeArea()
                VStack {
                    VStack {
                        TextField("First name...", text: $firstName)
                            .frame(width: 350, height: 50)
                        Divider()
                    }
                    VStack {
                        TextField("Last name...", text: $lastName)
                            .frame(width: 350, height: 50)
                        Divider()
                    }
                    VStack {
                        TextField("Email...", text: $email)
                            .frame(width: 350, height: 50)
                            .autocapitalization(.none)
                        Divider()
                    }
                    VStack {
                        HStack {
                            if isVisible {
                                TextField("Enter your password...", text: $password)
                                    .frame(width: 350, height: 50)
                                    .autocapitalization(.none)
                            } else {
                                SecureField("Enter your password...", text: $password)
                                    .frame(width: 350, height: 50)
                                    .autocapitalization(.none)
                            }
                        }
                        .overlay(alignment: .trailing) {
                            Image(systemName: isVisible ? "eye" : "eye.slash")
                                .foregroundColor(.gray)
                                .onTapGesture {
                                    self.isVisible.toggle()
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
                            TextField("Phone number...", text: $phoneNumber)
                                .frame(width: 350, height: 50)
                                .keyboardType(.numberPad)
                        }
                        .padding(.leading, 25)
                        Divider()
                    }
                    Button {
                        model.singUp(firstName: firstName, lastName: lastName, email: email, password: password, phoneNumber: phoneNumber)
                    } label: {
                        Text("Sign Up")
                    }
                    .frame(width: 350, height: 50)
                    .background(.black)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
                    .fullScreenCover(isPresented: $model.isAuthenticated, content: HealthRecordsView.init)
//                    ZStack {
//                        Divider()
//                        Text("or sign in with")
//                            .frame(width: 125, height: 25)
//                            .foregroundColor(.gray)
//                    }
//                    .padding(.top, 1)
//                    HStack {
//                        Button {
//                            
//                        } label: {
//                            Image("google.logo")
//                                .resizable()
//                                .frame(width: 40, height: 40)
//                                .background(.white)
//                                .cornerRadius(20)
//                                .shadow(color: .gray, radius: 2, x: 0, y: 0)
//                        }
//                        .padding()
//                        Button {
//                            
//                        } label: {
//                            Image("apple.logo")
//                                .resizable()
//                                .frame(width: 40, height: 40)
//                                .background(.white)
//                                .cornerRadius(20)
//                                .shadow(color: .gray, radius: 2, x: 0, y: 0)
//                        }
//                        .padding()
//                        Button {
//                            
//                        } label: {
//                            Image("facebook.logo")
//                                .resizable()
//                                .frame(width: 40, height: 40)
//                                .background(.white)
//                                .cornerRadius(20)
//                                .shadow(color: .gray, radius: 2, x: 0, y: 0)
//                        }
//                        .padding()
//                    }
                    Divider()
                }
                .padding(.top, 50)
                Spacer()
            }
            .navigationTitle("Sign Up")
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}