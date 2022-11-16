//
//  HealthError.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 10/1/22.
//

import Foundation


enum HealthError: LocalizedError {
    case unavailableOnThisDevice
    case unableToAuthorize
    case unableToWriteHealthRecord
    case thrownError(Error)
    case unableToReadHealthRecord
    
    var errorDescription: String {
        switch self {
        case .unavailableOnThisDevice:
            return "Unavailable on this device."
        case .unableToAuthorize:
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
