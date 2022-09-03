//
//  SignUpViewModel.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 9/2/22.
//

import Foundation


protocol AuthViewManagerProtocol {
    func singUp(firstName: String, lastName: String, email: String, password: String, phoneNumber: String)
}


class SignUpViewModel: ObservableObject, AuthViewManagerProtocol {
    //MARK: - Properties
    
    //MARK: - Functions
    func singUp(firstName: String, lastName: String, email: String, password: String, phoneNumber: String) {
        let user = User(firstName: firstName, lastName: lastName, email: email, password: password, phoneNumber: phoneNumber)
        AuthManager.shared?.signUp(user: user, completion: { (user, error) in
            print("USER: \(user)")
        })
    }
}
