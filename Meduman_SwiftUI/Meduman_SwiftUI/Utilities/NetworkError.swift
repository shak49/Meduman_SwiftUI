//
//  NetworkError.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 4/3/23.
//

import Foundation


enum NetworkError: LocalizedError, Error {
    case badUrl
    case unableToFindServer
    case unableToDecode
    case noDataAvailable
    case invalidServerResponse
    case thrownError(Error)
    
    var errorDescription: String {
        switch self {
        case .badUrl:
            return Constraint.shared.localizedString(key: "Network_URL_Error")
        case .unableToFindServer:
            return Constraint.shared.localizedString(key: "Network_Server_Error")
        case .unableToDecode:
            return Constraint.shared.localizedString(key: "Network_Decode_Error")
        case .noDataAvailable:
            return Constraint.shared.localizedString(key: "Network_Data_Error")
        case .invalidServerResponse:
            return Constraint.shared.localizedString(key: "Network_Respnse_Error")
        case .thrownError(let error):
            return "Error: \(error.localizedDescription) -> \(error)."
        }
    }
}
