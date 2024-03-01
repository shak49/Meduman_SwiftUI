//
//  FirebaseService.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 9/8/22.
//

import UIKit
import CryptoKit
import GoogleSignIn
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import AuthenticationServices


protocol FirebaseAuthStorage {
    // SHAK: Functions
    func getCurrentUser() async throws -> FirebaseAuth.User
    func initiateSignInWithApple(request: ASAuthorizationAppleIDRequest)
    func getAppleCredential(result: Result<ASAuthorization, Error>) async -> Result<User?, AuthError>?
    func signOut()
}

protocol FirebaseReminderStorage {
    typealias ReminderHandler = (Reminder?, ReminderError?) -> Void
    
    //MARK: - Functions
    func fetchListOfReminders(completion: @escaping ReminderHandler)
    func createReminder(reminder: Reminder?, completion: @escaping(Bool?, ReminderError?) -> Void)
}

class FirebaseService: NSObject, FirebaseAuthStorage, FirebaseReminderStorage {
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
    
    func initiateSignInWithApple(request: ASAuthorizationAppleIDRequest) {
        let nonce = randomNonceString()
        currentNonce = nonce
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
    }
    
    func getAppleCredential(result: Result<ASAuthorization, Error>) async -> Result<User?, AuthError>? {
        switch result {
        case .success(let authorization):
            guard let appleIdCredential = authorization.credential as? ASAuthorizationAppleIDCredential else { return .failure(.unableToGetCredential) }
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            guard let appleIDToken = appleIdCredential.identityToken else { return .failure(.noIdentityToken) }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else { return .failure(.unableToConvertToStringEncoding) }
            do {
                let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
                return try await .success(signIn(credential: credential)  )
            } catch {
                return .failure(.thrownError(error))
            }
        case .failure(let error):
            print("ERROR: \(error.localizedDescription)")
        }
        return nil
    }
    
    func signOut() {
        do {
            try auth?.signOut()
            self.user = nil
        } catch let signOutError as NSError {
            print("Error signning-out: \(signOutError)")
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
        return User(authUser: user)
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
