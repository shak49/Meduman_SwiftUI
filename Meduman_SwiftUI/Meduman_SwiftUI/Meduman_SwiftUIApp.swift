//
//  Meduman_SwiftUIApp.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 12/21/21.
//

import SwiftUI
import Firebase
import HealthKit

@main
struct Meduman_SwiftUIApp: App {
    //MARK: - Properties
    @StateObject var healthModel = HealthRecordViewModel()
    @StateObject var reminderModel = MedicationReminderViewModel()
    
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
            TabContainerView()
                .environmentObject(healthModel)
                .environmentObject(reminderModel)
        }
    }
}
