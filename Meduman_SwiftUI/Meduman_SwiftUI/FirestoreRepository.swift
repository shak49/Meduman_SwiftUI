//
//  FBFirestoreRepo.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 9/8/22.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift


protocol FirestoreProtocol {
    // SHAK: Properties
    var firestore: Firestore { get }
    typealias AuthHandler = (User?, AuthError?) -> Void
    typealias ReminderHandler = (Reminder?, ReminderError?) -> Void
    
    // SHAK: Functions
    func createUserProfile(user: User?, completion: @escaping AuthHandler)
    func fetchUserProfile(userId: String?, completion: @escaping AuthHandler)
    func fetchListOfReminders(completion: @escaping ReminderHandler)
    func createReminder(reminder: Reminder?, completion: @escaping(Bool?, ReminderError?) -> Void)
}


class FirestoreRepository: FirestoreProtocol {
    //MARK: - Properties
    var firestore = Firestore.firestore()
    
    //MARK: - Lifecycles
    
    //MARK: - Functions
    func createUserProfile(user: User?, completion: @escaping AuthHandler) {
        guard let user = user else { return }
        do {
            try firestore.collection("users").document(user.id ?? "").setData(from: user)
            completion(user, .unableToCreateUser)
        } catch let error {
            print("Error writing user to Firestore: \(error)")
            completion(nil, error as? AuthError)
        }
    }
    
    func fetchUserProfile(userId: String?, completion: @escaping AuthHandler) {
        guard let userId = userId else { return }
        firestore.collection("users").document(userId).getDocument { [weak self] (snapshot, error) in
            let userProfile = try? snapshot?.data(as: User.self)
            completion(userProfile, .noUser)
        }
    }
    
    func fetchListOfReminders(completion: @escaping ReminderHandler) {
        firestore.collection("reminders").getDocuments { snapshot, error in
            if error != nil {
                completion(nil, .unableToFetchListOfReminders)
            }
            guard let documents = snapshot?.documents else { return }
            for document in documents {
                let data = document.data()
                let reminder = Reminder(medicine: data["medicine"] as? String ?? "", dosage: data["dosage"] as? String ?? "", date: data["date"] as? Date ?? Date(), frequency: data["frequency"] as? String ?? "", time: data["time"] as? Date ?? Date(), mealTime: data["mealTime"] as? String ?? "", description: data["description"] as? String ?? "")
                completion(reminder, nil)
            }
        }
    }
    
    func createReminder(reminder: Reminder?, completion: @escaping(Bool?, ReminderError?) -> Void) {
        guard let reminder = reminder else {
            completion(nil, .unableToFindReminder)
            return
        }
        self.firestore.collection("reminders").document(reminder.id ?? "").setData([
            "id" : reminder.id,
            "medicine" : reminder.medicine,
            "dosage" : reminder.dosage,
            "date" : reminder.date,
            "frequency" : reminder.frequency,
            "time" : reminder.time,
            "mealTime" : reminder.mealTime,
            "description" : reminder.description
        ]) { error in
            if error != nil {
                completion(nil, .unableToCreateReminder)
            }
        }
        completion(true, nil)
    }
}
