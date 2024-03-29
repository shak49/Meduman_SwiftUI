//
//  SettingsVM.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 3/26/24.
//

import SwiftUI

class SettingsVM: BaseVM {
    //MARK: - Properties
    
    //MARK: - Functions
    func signOut() {
        firebaseService.signOut()
        getUserInfo()
    }
}
