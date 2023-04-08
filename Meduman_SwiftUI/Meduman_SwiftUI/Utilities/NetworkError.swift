//
//  NetworkError.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 4/3/23.
//

import Foundation


enum NetworkError: LocalizedError, Error {
    case badUrl
    case unableToFindData
    case unableToDecode
    case noDataAvailable
    case invalidServerResponse
    case thrownError(Error)
    
    var errorDescription: String {
        switch self {
        case .badUrl:
            return "Bad URL."
        case .unableToFindData:
            return "Unable to find server."
        case .unableToDecode:
            return "Unable to decode."
        case .noDataAvailable:
            return "No data found."
        case .invalidServerResponse:
            return "Invalid server response."
        case .thrownError(let error):
            return "Error: \(error.localizedDescription) -> \(error)."
        }
    }
}
