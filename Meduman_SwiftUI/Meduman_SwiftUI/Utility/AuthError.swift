//
//  DatabaseError.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 12/22/21.
//

import Foundation


enum AuthError: LocalizedError {
    case unableToCreateUser
    case thrownError(Error)
    case noUser
    
    var errorDescription: String {
        switch self {
        case .unableToCreateUser:
            return "Unable to create the user."
        case .thrownError(let error):
            return "Error: \(error.localizedDescription) -> \(error)"
        case .noUser:
            return "The server responded with no data."
        }
    }
}
