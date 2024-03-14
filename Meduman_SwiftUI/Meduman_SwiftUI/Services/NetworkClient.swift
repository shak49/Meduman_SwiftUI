//
//  NetworkService.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 3/12/24.
//

import Foundation


class NetworkClient {
    //MARK: - Properties
    static let shared = NetworkClient()
    
    //MARK: - Lifecycles
    private init() {}
    
    //MARK: - Functions
    func request<RESP: Codable>(request: URLRequest, type: RESP) async -> Result<RESP, NetworkError> {
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
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
