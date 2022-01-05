//
//  SignUpView.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 1/5/22.
//

import SwiftUI

struct SignUpView: View {
    // SHAK: Properties
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
                        Divider()
                    }
                    VStack {
                        TextField("Password...", text: $password)
                            .frame(width: 350, height: 50)
                        Divider()
                    }
                    VStack {
                        TextField("Phone number...", text: $phoneNumber)
                            .frame(width: 350, height: 50)
                        Divider()
                    }
                    Button {
                        
                    } label: {
                        Text("Sign Up")
                    }
                    .frame(width: 350, height: 50)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
                    Spacer()
                }
                .padding(.top, 50)
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
