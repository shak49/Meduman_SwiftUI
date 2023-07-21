//
//  ReminderError.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 7/21/23.
//

import Foundation


enum ReminderError: LocalizedError {
    case unableToFindReminder
    case unableToCreateReminder
    case unableToFetchListOfReminders
    
    var description: String {
        switch self {
        case .unableToFindReminder:
            return "Unable to find reminder."
        case .unableToCreateReminder:
            return "Firestore repository is unable to create a reminder."
        case .unableToFetchListOfReminders:
            return "Firestore repository is unable to fetch list of reminders."
        }
    }
}
