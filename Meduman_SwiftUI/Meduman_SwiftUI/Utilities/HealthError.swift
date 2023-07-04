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
            return Constraint.shared.localizedString(key: "Health_Unavailable_Error")
        case .unableToAccessRecordsForThisDevice:
            return Constraint.shared.localizedString(key: "Health_Access_Error")
        case .unableToAuthorizeAccess:
            return Constraint.shared.localizedString(key: "Health_Authorize_Error")
        case .unableToWriteHealthRecord:
            return Constraint.shared.localizedString(key: "Health_Write_Error")
        case .unableToReadHealthRecord:
            return Constraint.shared.localizedString(key: "Health_Read_Error")
        case .unableToRemoveHealthRecord:
            return Constraint.shared.localizedString(key: "Health_Remove_Error")
        case .serverError(let error):
            return "Error: \(error.localizedDescription)"
        }
    }
}
