//
//  HealthError.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 10/1/22.
//

import Foundation


enum HealthError: LocalizedError {
    case typeNotAvailable
    case unableToAccessRecordsForThisDevice
    case unableToAuthorizeAccess
    case unableToWriteHealthRecord
    case unableToReadHealthRecord
    case unableToRemoveHealthRecord
    case serverError(Error)
    
    var errorDescription: String {
        switch self {
        case .typeNotAvailable:
            return "Type is not available."
        case .unableToAccessRecordsForThisDevice:
            return "Unable to access health records for this device."
        case .unableToAuthorizeAccess:
            return "Unable to authorize access."
        case .unableToWriteHealthRecord:
            return "Unable to write health record."
        case .unableToReadHealthRecord:
            return "The \'HealthKit\' responded with no data."
        case .unableToRemoveHealthRecord:
            return "Unable to remove health record."
        case .serverError(let error):
            return "Error: \(error.localizedDescription)"
        }
    }
}
