//
//  Reminder.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 7/21/23.
//

import Foundation
import Firebase


struct Reminder: Identifiable {
    var id: String = UUID().uuidString
    var medicine: String
    var dosage: String
    var date: Date
    var frequency: String
    var time: Date
    var mealTime: String
    var description: String
}
