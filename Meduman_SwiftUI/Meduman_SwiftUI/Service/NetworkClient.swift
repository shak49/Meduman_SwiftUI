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
        do {
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
        } catch {
            throw NetworkError.customError(error)
        }
    }
}

extension NetworkClient {
    enum NetworkError: LocalizedError, Equatable {
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
    
}

extension NetworkClient.NetworkError {
    static func ==(lhs: NetworkClient.NetworkError, rhs: NetworkClient.NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.customError(let lhsCustom), .customError(let rhsCustom)):
            return lhsCustom.localizedDescription == rhsCustom.localizedDescription
        case (.invalidURL, .invalidURL):
            return true
        case (.invalidResponse(let lhsCode), .invalidResponse(let rhsCode)):
            return lhsCode == rhsCode
        case (.unableToDecode, .unableToDecode):
            return true
        case (.unableToGetData, .unableToGetData):
            return true
        default:
            return false
        }
    }
}
