//
//  NetworkService.swift
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

final class NetworkClient {
    //MARK: - Properties
    static let shared = NetworkClient()
    private lazy var session = URLSession.shared
    
    //MARK: - Lifecycles
    private init() {}
    
    //MARK: - Functions
    func request<RESP: Codable>(request: URLRequest, type: RESP.Type) async -> Result<RESP, NetworkError> {
        do {
            let (data, response) = try await self.session.data(for: request)
            guard let response = response as? HTTPURLResponse, (200...300) ~= response.statusCode else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode
                return .failure(.invalidResponse(code: statusCode!))
            }
            guard let result = try? JSONDecoder().decode(RESP.self, from: data) else {
                return .failure(.unableToDecode)
            }
            return .success(result)
        } catch {
            return .failure(.customError(error))
        }
    }
}
