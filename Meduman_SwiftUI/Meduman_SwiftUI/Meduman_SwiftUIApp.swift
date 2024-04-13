//
//  Meduman_SwiftUIApp.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 12/21/21.
//

import SwiftUI
import UIKit
import Firebase
import HealthKit
import GoogleSignIn


@main
struct Meduman_SwiftUIApp: App {
    //MARK: - Properties
    @StateObject var healthModel = HealthRecordViewModel()
    private var navigator = Navigator()
    
    //MARK: - Lifecycles
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
            MainView()
                .environmentObject(navigator)
                .environmentObject(healthModel)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    //MARK: - Methods
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
}
