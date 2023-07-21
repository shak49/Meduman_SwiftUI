//
//  MedicationViewModel.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 7/7/23.
//

import Foundation


class MedicationReminderViewModel: ObservableObject {
    //MARK: - Properties
    var repo = FirestoreRepository()
    
    //MARK: - Lifecycles
    init() {
        fetchListOfReminders()
    }
    
    //MARK: - Functions
    func fetchListOfReminders() {
        
    }
    
    func createReminder(medicine: String?, dosage: String?, date: Date?, frequency: String?, time: Date?, afterMeal: String?, description: String?) {
        guard let medicine = medicine, let dosage = dosage, let date = date, let frequency = frequency, let time = time, let afterMeal = afterMeal, let description = description else { return }
        let reminder = Reminder(medicine: medicine, dosage: dosage, date: date, frequency: frequency, time: time, afterMeal: afterMeal, description: description)
        self.repo.createReminder(reminder: reminder) { success, error in
            if error != nil {
                print(error)
            }
            guard let success = success else { return }
            print("Successfully created a reminder: \(success)")
        }
    }
}
