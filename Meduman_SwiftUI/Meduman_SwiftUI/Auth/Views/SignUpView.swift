//
//  SignUpView.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 1/5/22.
//

import SwiftUI

struct SignUpView: View {
    // SHAK: Properties
    @ObservedObject private var model = AuthViewModel()
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var phoneNumber: String = ""
    
    // SHAK: Body
    var body: some View {
        NavigationView {
            ZStack {
                Image("Background.Image")
                    .resizable()
                    .scaledToFill()
                .scaleEffect(1.5)
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
                        SecureField("Password...", text: $password)
                            .frame(width: 350, height: 50)
                            .autocapitalization(.none)
                        Divider()
                    }
                    VStack {
                        HStack {
                            Button {
                                
                            } label: {
                                Text("+1")
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            TextField("Phone number...", text: $phoneNumber)
                                .frame(width: 350, height: 50)
                                .keyboardType(.decimalPad)
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
