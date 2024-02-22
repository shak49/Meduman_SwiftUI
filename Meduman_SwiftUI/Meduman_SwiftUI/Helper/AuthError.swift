//
//  DatabaseError.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 12/22/21.
//

import Foundation


enum AuthError: LocalizedError {
    case unableToCreateUser
    case unableToConvertToStringEncoding
    case unableToGetCredential
    case thrownError(Error)
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
        case .thrownError(let error):
            return "Error: \(error.localizedDescription) -> \(error)"
        case .noIdentityToken:
            return "Unable to get identity token."
        case .noUser:
            return "The server responded with no data."
        }
    }
}
