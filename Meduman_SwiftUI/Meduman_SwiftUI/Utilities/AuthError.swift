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
            return Constraint.shared.localizedString(key: "User_Creation_Error")
        case .thrownError(let error):
            return "Error: \(error.localizedDescription)"
        case .noUser:
            return Constraint.shared.localizedString(key: "User_NotFound_Error")
        }
    }
}
