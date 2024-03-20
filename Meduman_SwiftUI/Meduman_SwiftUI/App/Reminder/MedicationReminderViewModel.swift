//
//  MedicationViewModel.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 7/7/23.
//

import Foundation
import Combine


class MedicationReminderViewModel: BaseVM {
    //MARK: - Properties
    @Published var reminders: [Reminder] = []
    
    //MARK: - Lifecycles
    override init() {
        super.init()
        fetchReminders()
    }
    
    //MARK: - Functions
    func fetchReminders() {
        DispatchQueue.main.async {
            self.firebaseService.fetchListOfReminders { reminder, error in
                if let error = error {
                    print(error)
                }
                guard let reminder = reminder else { return }
                self.reminders.append(reminder)
            }
        }
    }
    
    func createReminder(medicine: String, dosage: String, date: Date, frequency: String, time: Date, afterMeal: String, description: String) {
        let reminder = Reminder(medicine: medicine, dosage: dosage, date: date, frequency: frequency, time: time, mealTime: afterMeal, description: description)
        self.reminders.append(reminder)
        firebaseService.createReminder(reminder: reminder) { success, error in
            if error != nil {
                print(error)
            }
            guard let success = success else { return }
            print("Successfully created a reminder: \(success)")
            NotificationManager.shared.createLocalNotification(reminder: reminder)
        }
    }
}
