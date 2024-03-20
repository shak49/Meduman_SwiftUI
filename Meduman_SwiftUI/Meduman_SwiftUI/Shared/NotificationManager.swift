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
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
            let request = UNNotificationRequest(identifier: reminder.id, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request)
        }
    }
    
}
