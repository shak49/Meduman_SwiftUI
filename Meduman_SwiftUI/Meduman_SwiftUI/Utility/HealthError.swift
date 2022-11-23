//
//  HealthError.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 10/1/22.
//

import Foundation


enum HealthError: LocalizedError {
    case unableToAuthorizeAccess
    case unableToWriteHealthRecord
    case thrownError(Error)
    case unableToReadHealthRecord
    
    var errorDescription: String {
        switch self {
        case .unableToAuthorizeAccess:
            return "Unable to authorize access."
        case .unableToWriteHealthRecord:
            return "Unable to create the user."
        case .thrownError(let error):
            return "Error: \(error.localizedDescription) -> \(error)"
        case .unableToReadHealthRecord:
            return "The server responded with no data."
        }
    }
}
