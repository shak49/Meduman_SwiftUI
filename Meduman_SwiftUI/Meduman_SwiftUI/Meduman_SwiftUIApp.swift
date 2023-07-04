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
    static var healthStore = HKHealthStore()
    static var healthQuery: HKSampleQuery?
    static var healthRepo = HealthRepository(healthStore: healthStore, healthQuery: healthQuery)
    static var useCase = HealthUseCase(repo: healthRepo)
    @StateObject var healthModel = HealthRecordViewModel(useCase: useCase)
    
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
            //SignInView()
            //SignUpView()
            HealthRecordsView()
                .environmentObject(healthModel)
        }
    }
}
