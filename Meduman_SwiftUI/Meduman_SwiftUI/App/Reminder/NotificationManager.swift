//
//  LocalNotificationManager.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 7/22/23.
//

import Foundation
import UserNotifications


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
