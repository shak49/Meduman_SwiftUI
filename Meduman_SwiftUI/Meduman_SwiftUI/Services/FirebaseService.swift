//
//  FirebaseService.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 9/8/22.
//

import UIKit
import CryptoKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import AuthenticationServices


protocol AuthProtocol {
    // SHAK: Functions
    func signUp(user: User?, completion: @escaping(FirebaseAuth.User?, AuthError?) -> Void)
    func signIn(email: String?, password: String?, completion: @escaping(FirebaseAuth.User?, AuthError?) -> Void)
    func signOut()
}

protocol FirestoreUserStorage {
    typealias AuthHandler = (User?, AuthError?) -> Void
    
    //MARK: - Functions
    func createUserProfile(user: User?, completion: @escaping AuthHandler)
    func fetchUserProfile(userId: String?, completion: @escaping AuthHandler)
}

protocol FirebaseReminderStorage {
    typealias ReminderHandler = (Reminder?, ReminderError?) -> Void
    
    //MARK: - Functions
    func fetchListOfReminders(completion: @escaping ReminderHandler)
    func createReminder(reminder: Reminder?, completion: @escaping(Bool?, ReminderError?) -> Void)
}

class FirebaseService: NSObject, AuthProtocol, FirestoreUserStorage, FirebaseReminderStorage {
    //MARK: - Properties
    private var firestore = Firestore.firestore()
    private var auth: Auth? = Auth.auth()
    private var user: User?
    fileprivate var currentNonce: String?
    
    //MARK: - Functions
    func getCurrentUser() async throws -> FirebaseAuth.User {
        guard let user = auth?.currentUser else {
            throw AuthError.noUser
        }
        return user
    }
    
    func initiateSignInWithAppleFlow(request: ASAuthorizationAppleIDRequest) {
        let nonce = randomNonceString()
        currentNonce = nonce
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
    }
    
    func getCredential(result: Result<ASAuthorization, Error>) async throws -> User? {
        switch result {
        case .success(let authorization):
            guard let appleIdCredential = authorization.credential as? ASAuthorizationAppleIDCredential else {
                throw AuthError.unableToGetCredential
            }
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            guard let appleIDToken = appleIdCredential.identityToken else {
                throw AuthError.noIdentityToken
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                throw AuthError.unableToConvertToStringEncoding
            }
            let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
            return try await signIn(credential: credential)
        case .failure(let error):
            print("ERROR: \(error.localizedDescription)")
        }
        return nil
    }
    
    func signUp(user: User?, completion: @escaping(FirebaseAuth.User?, AuthError?) -> Void) {
        guard let email = user?.email, let password = user?.password else { return }
        auth?.createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("Error: \(error)")
                completion(nil, .unableToCreateUser)
                return
            }
            completion(result?.user, nil)
        }
    }
    
    func signIn(email: String?, password: String?, completion: @escaping(FirebaseAuth.User?, AuthError?) -> Void) {
        guard let email = email, let password = password else { return }
        auth?.signIn(withEmail: email, password: password) { [weak self] (result, error) in
            if let error = error {
                completion(nil, .noUser)
                return
            }
            guard let result = result else { return }
            completion(result.user, nil)
        }
    }
    
    func signOut() {
        do {
            try auth?.signOut()
            self.user = nil
        } catch let signOutError as NSError {
            print("Error signning-out: \(signOutError)")
        }
    }
    
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
            completion(userProfile, nil)
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

extension FirebaseService {
    //MARK: - Functions
    private func signIn(credential: AuthCredential) async throws -> User {
        let user = try await auth?.signIn(with: credential).user
        return User(displayName: user?.displayName, email: user?.email)
    }
    
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        var randomBytes = [UInt8](repeating: 0, count: length)
        let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
        if errorCode != errSecSuccess {
            fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
        }
        let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        let nonce = randomBytes.map { byte in
            charset[Int(byte) % charset.count]
        }
        return String(nonce)
    }
    
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            String(format: "%02x", $0)
        }.joined()
        return hashString
    }
}
