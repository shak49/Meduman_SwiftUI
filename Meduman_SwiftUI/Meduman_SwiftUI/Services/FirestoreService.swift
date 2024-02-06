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
    typealias AuthHandler = (User?, AuthError?) -> Void
    typealias ReminderHandler = (Reminder?, ReminderError?) -> Void
    
    // SHAK: Properties
    var firestore: Firestore { get }
    
    // SHAK: Functions
    func createUserProfile(user: User?, completion: @escaping AuthHandler)
    func fetchUserProfile(userId: String?, completion: @escaping AuthHandler)
    func fetchListOfReminders(completion: @escaping ReminderHandler)
    func createReminder(reminder: Reminder?, completion: @escaping(Bool?, ReminderError?) -> Void)
}


class FirestoreService: FirestoreProtocol {
    //MARK: - Properties
    var firestore = Firestore.firestore()
    
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
            if let error = error {
                completion(nil, .unableToFetchListOfReminders)
            }
            guard let documents = snapshot?.documents else { return }
            documents.map { document in
                do {
                    let reminder = try document.data(as: Reminder.self)
                    completion(reminder, nil)
                } catch {
                    print("Error decoding reminders!")
                }
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
