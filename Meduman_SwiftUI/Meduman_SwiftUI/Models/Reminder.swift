//
//  Reminder.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 7/21/23.
//

import Foundation


struct Reminder: Codable, Identifiable {
    var id: String
    var medicine: String
    var dosage: String
    var date: Date
    var frequency: String
    var time: Date
    var afterMeal: String
    var description: String
    
    init(id: String = UUID().uuidString, medicine: String, dosage: String, date: Date, frequency: String, time: Date, afterMeal: String, description: String) {
        self.id = id
        self.medicine = medicine
        self.dosage = dosage
        self.date = date
        self.frequency = frequency
        self.time = time
        self.afterMeal = afterMeal
        self.description = description
    }
}
