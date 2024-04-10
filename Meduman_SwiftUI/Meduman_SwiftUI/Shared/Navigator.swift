//
//  Navigator.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 4/9/24.
//

import Foundation

class Navigator: ObservableObject {
    //MARK: - Properties
    @Published private(set) var currentScreen = Screen.signIn
    
    //MARK: - Functions
    func push(to screen: Screen) {
        currentScreen = screen
    }
}
