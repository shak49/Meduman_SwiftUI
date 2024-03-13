//
//  NetworkError.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 3/12/24.
//

import Foundation


enum NetworkError: Error {
    case customError(_ error: Error)
    case invalidURL
    case invalidResponse(code: Int)
    case unableToDecode
    case unableToGetData
    
    private var description: String {
        switch self {
        case .customError(let error):
            return "\(error.localizedDescription)"
        case .invalidURL:
            return "This URL is not valid!"
        case .invalidResponse(code: let code):
            return "\(code) status code is not valid!"
        case .unableToDecode:
            return "Unable to decode data!"
        case .unableToGetData:
            return "Unable to get data!"
        }
    }
}
