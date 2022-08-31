//
//  SignInView.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 12/28/21.
//

import SwiftUI


struct SignInView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    
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
                        Divider()
                    }
                    VStack {
                        SecureField("Enter your password...", text: $password)
                            .frame(width: 350, height: 50)
                        Divider()
                    }
                        .padding()
                    Button {
                        
                    } label: {
                        Text("Sign In")
                            .foregroundColor(.white)
                    }
                    .frame(width: 350, height: 50)
                    .background(.black)
                    .cornerRadius(10)
                    .padding(.top, 50)
                    ZStack {
                        Divider()
                        Text("or sign in with")
                            .frame(width: 125, height: 25)
                            
                            .foregroundColor(.gray)
                    }
                    HStack {
                        Button {
                            
                        } label: {
                            Image("google.logo")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .background(.white)
                                .cornerRadius(20)
                                .shadow(color: .gray, radius: 2, x: 0, y: 0)
                        }
                        .padding()
                        Button {
                            
                        } label: {
                            Image("apple.logo")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .background(.white)
                                .cornerRadius(20)
                                .shadow(color: .gray, radius: 2, x: 0, y: 0)
                        }
                        .padding()
                        Button {
                            
                        } label: {
                            Image("facebook.logo")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .background(.white)
                                .cornerRadius(20)
                                .shadow(color: .gray, radius: 2, x: 0, y: 0)
                        }
                        .padding()
                    }
                    Divider()
                    VStack {
                        Button {
                            
                        } label: {
                            Text("Forgot your password?")
                                .foregroundColor(.gray)
                        }
                        Button {
                            
                        } label: {
                            Text("Create a new account.")
                                .foregroundColor(.gray)
                        }
                        .padding()
                    }
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
