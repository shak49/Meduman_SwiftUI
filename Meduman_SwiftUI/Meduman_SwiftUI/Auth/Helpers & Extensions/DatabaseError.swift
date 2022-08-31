//
//  DatabaseError.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 12/22/21.
//

import Foundation


enum DatabaseError: Error {
    case unableToCreate
    case thrownError(Error)
    case noData
    
    var errorDescription: String {
        switch self {
        case .unableToCreate:
            return "Unable to create the user."
        case .thrownError(let error):
            return "Error: \(error.localizedDescription) -> \(error)"
        case .noData:
            return "The server responded with no data."
        }
    }
}
