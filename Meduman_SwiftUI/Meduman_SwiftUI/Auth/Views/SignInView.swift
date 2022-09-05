//
//  SignInView.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 12/28/21.
//

import SwiftUI


struct SignInView: View {
    @ObservedObject private var model = AuthViewModel()
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPresented: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("Background.Image")
                    .resizable()
                    .scaledToFill()
                .scaleEffect(1.5)
                VStack {
                    VStack {
                        TextField("Enter your email...", text: $email)
                            .frame(width: 350, height: 50)
                            .textCase(.lowercase)
                        Divider()
                    }
                    VStack {
                        SecureField("Enter your password...", text: $password)
                            .frame(width: 350, height: 50)
                            .textCase(.none)
                        Divider()
                    }
                        .padding()
                    Button {
                        model.signIn(email: email, password: password)
                    } label: {
                        Text("Sign In")
                            .foregroundColor(.white)
                    }
                    .frame(width: 350, height: 50)
                    .background(.black)
                    .cornerRadius(10)
                    .padding(.top, 50)
                    .fullScreenCover(isPresented: $model.isAuthenticated, content: RecordView.init)
//                    ZStack {
//                        Divider()
//                        Text("or sign in with")
//                            .frame(width: 125, height: 25)
//
//                            .foregroundColor(.gray)
//                    }
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
                        .padding(.top, 25)
                    VStack {
                        Button {
                            
                        } label: {
                            Text("Forgot your password?")
                                .foregroundColor(.blue)
                        }
                        Button {
                            self.isPresented.toggle()
                        } label: {
                            Text("Create a new account.")
                                .foregroundColor(.blue)
                        }
                        .popover(isPresented: $isPresented, content: {
                            SignUpView()
                        })
                        .padding()
                    }
                    .padding(.top, 35)
                }
                .padding(.top)
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
