//
//  NetworkService.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 3/12/24.
//

import Foundation

protocol NetworkClientProtocol {
    //MARK: - Functions
    func request<RESP: Codable>(endpoint: Endpoint, type: RESP.Type) async throws -> RESP
}

final class NetworkClient: NetworkClientProtocol {
    //MARK: - Properties
    var session: URLSession
    
    //MARK: - Lifecycles
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    //MARK: - Functions
    func request<RESP: Codable>(endpoint: Endpoint, type: RESP.Type) async throws -> RESP {
        guard let url = endpoint.url else { throw NetworkError.invalidURL }
        var request = URLRequest(url: url)
        let (data, response) = try await self.session.data(for: request)
        guard let response = response as? HTTPURLResponse, (200...300) ~= response.statusCode else {
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            throw NetworkError.invalidResponse(code: statusCode!)
        }
        guard let result = try? JSONDecoder().decode(RESP.self, from: data) else {
            throw NetworkError.unableToDecode
        }
        return result
    }
}

extension NetworkClient {
    enum NetworkError: LocalizedError {
        case custom(_ error: Error)
        case invalidURL
        case invalidResponse(code: Int)
        case unableToDecode
        case unableToGetData
        
        var errorDescription: String {
            switch self {
            case .custom(error: let error):
                return "Something went wrong, ERROR: \(error.localizedDescription)"
            case .invalidURL:
                return "This URL is not valid!"
            case .invalidResponse:
                return "Status code is not valid!"
            case .unableToDecode:
                return "Unable to decode data!"
            case .unableToGetData:
                return "Unable to get data!"
            }
        }
    }
    
}

extension NetworkClient.NetworkError: Equatable {
    static func == (lhs: NetworkClient.NetworkError, rhs: NetworkClient.NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.custom(let lhsCustom), .custom(let rhsCustom)):
            return lhsCustom.localizedDescription == rhsCustom.localizedDescription
        case (.invalidURL, .invalidURL):
            return true
        case (.invalidResponse, .invalidResponse):
            return true
        case (.unableToDecode, .unableToDecode):
            return true
        case (.unableToGetData, .unableToGetData):
            return true
        default:
            return false
        }
    }
}
