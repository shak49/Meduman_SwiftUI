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
        if ProcessInfo.processInfo.environment["unit_tests"] == "true" {
          print("Setting up Firebase emulator localhost:8080")
          let settings = Firestore.firestore().settings
          settings.host = "localhost:8081"
          settings.isPersistenceEnabled = false
          settings.isSSLEnabled = false
          Firestore.firestore().settings = settings
        }
    }
    
    var body: some Scene {
        WindowGroup {
            SignInView()
            //SignUpView()
        }
    }
}