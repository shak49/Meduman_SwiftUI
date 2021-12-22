//
//  Meduman_SwiftUIApp.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 12/21/21.
//

import SwiftUI
import Firebase

@main
struct Meduman_SwiftUIApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
