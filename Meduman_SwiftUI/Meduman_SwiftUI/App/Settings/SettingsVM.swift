//
//  SettingsVM.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 3/26/24.
//

import SwiftUI

class SettingsVM: BaseVM {
    //MARK: - Properties
    @Published var isDarkOn: Bool = false
    
    //MARK: - Functions
    func signOut(push: () -> Void) {
        if let signedOut = firebaseService.signOut(), signedOut == true {
            push()
        }
    }
}
