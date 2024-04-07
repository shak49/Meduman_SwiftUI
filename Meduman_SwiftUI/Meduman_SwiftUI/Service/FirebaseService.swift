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

enum AuthError: LocalizedError {
    case unableToCreateUser
    case unableToConvertToStringEncoding
    case unableToGetCredential
    case unableToGetView
    case thrownError(Error)
    case noClientId
    case noIdentityToken
    case noUser
    
    var errorDescription: String {
        switch self {
        case .unableToCreateUser:
            return "Unable to create the user."
        case .unableToConvertToStringEncoding:
            return "Unable to convert to string encoding"
        case .unableToGetCredential:
            return "Unable to get credential."
        case .unableToGetView:
            return "Unable to get view!"
        case .thrownError(let error):
            return "Error: \(error.localizedDescription) -> \(error)"
        case .noClientId:
            return "Unable to find client id."
        case .noIdentityToken:
            return "Unable to get identity token."
        case .noUser:
            return "The server responded with no data."
        }
    }
}

enum ReminderError: LocalizedError {
    case noSnapshotAvailable
    case unableToFindReminder
    case unableToCreateReminder
    case unableToFetchListOfReminders
    
    var description: String {
        switch self {
        case .noSnapshotAvailable:
            return "There is no snapshot available."
        case .unableToFindReminder:
            return "Unable to find reminder."
        case .unableToCreateReminder:
            return "Firestore repository is unable to create a reminder."
        case .unableToFetchListOfReminders:
            return "Firestore repository is unable to fetch list of reminders."
        }
    }
}

protocol FirebaseAuthStorage {
    // SHAK: Functions
    func getCurrentUser() async throws -> FirebaseAuth.User
    func initiateSignInWithApple(request: ASAuthorizationAppleIDRequest)
    func getAppleCredential(result: Result<ASAuthorization, Error>) async -> Result<User?, AuthError>?
    func signInWithGoogle(view: UIViewController) async -> Result<User?, AuthError>?
    func signOut()
}

protocol FirebaseReminderStorage {
    typealias ReminderHandler = (Reminder?, ReminderError?) -> Void
    
    //MARK: - Functions
    func fetchListOfReminders(completion: @escaping ReminderHandler)
    func createReminder(reminder: Reminder?, completion: @escaping(Bool?, ReminderError?) -> Void)
}

final class FirebaseService: NSObject, FirebaseAuthStorage, FirebaseReminderStorage {
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
    
    func signInWithGoogle(view: UIViewController) async -> Result<User?, AuthError>? {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return .failure(.noClientId) }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        do {
            let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: view)
            guard let idToken = result.user.idToken?.tokenString else { return .failure(.noIdentityToken) }
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: result.user.accessToken.tokenString)
            return try await .success(signIn(credential: credential))
        } catch {
            return .failure(.thrownError(error))
        }
    }
    
    func signOut() {
        do {
            try auth?.signOut()
        } catch {
            print("Error signing-out: \(error)")
        }
    }
    
    private func signIn(credential: AuthCredential) async throws -> User {
        let user = try await auth?.signIn(with: credential).user
        return User(authUser: user)
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
