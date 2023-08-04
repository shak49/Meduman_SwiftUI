//
//  LocalNotificationManager.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 7/22/23.
//

import Foundation
import UserNotifications


enum RepeatFrequency: Double {
    case daily
    case weekly
    case monthly
    case annualy
    
    var value: Double {
        switch self {
        case .daily:
            return (60 * 1_440)
        case .weekly:
            return (60 * 1_440) * 7
        case .monthly:
            return (60 * 1_440) * 30
        case .annualy:
            return (60 * 1_440) * 365
        }
    }
}

class NotificationManager {
    //MARK: - Properties
    static let shared = NotificationManager()
    
    //MARK: - Lifecycles
    
    //MARK: - Functions
    func createLocalNotification(reminder: Reminder?) {
        guard let reminder = reminder else { return }
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if error != nil {
                print(error?.localizedDescription)
            }
            let content = UNMutableNotificationContent()
            content.title = reminder.medicine
            content.body = reminder.description
            let timeInterval = reminder.time.timeIntervalSinceNow
            if reminder.frequency == "Week" {
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval * RepeatFrequency.weekly.rawValue ?? 60.0, repeats: true)
                let request = UNNotificationRequest(identifier: reminder.id, content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request)
            } else if reminder.frequency == "Month" {
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval * RepeatFrequency.monthly.rawValue, repeats: true)
                let request = UNNotificationRequest(identifier: reminder.id, content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request)
            } else if reminder.frequency == "Year" {
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval * RepeatFrequency.annualy.rawValue, repeats: true)
                let request = UNNotificationRequest(identifier: reminder.id, content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request)
            } else {
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval * RepeatFrequency.daily.rawValue, repeats: true)
                let request = UNNotificationRequest(identifier: reminder.id, content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request)
            }
        }
    }
    
}
