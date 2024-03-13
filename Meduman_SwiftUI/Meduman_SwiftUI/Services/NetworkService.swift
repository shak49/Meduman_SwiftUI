//
//  NetworkService.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 3/12/24.
//

import Foundation


enum CodableType {
    case decoder = JSONDecoder()
    case encoder = JSONEncoder()
}

class NetworkService {
    //MARK: - Properties
    static let shared = NetworkService()
    
    //MARK: - Lifecycles
    private init() {}
    
    //MARK: - Functions
    func request<T: Codable>(endpoint: String, type: T) async -> Result<T, NetworkError>? {
        guard let url = URL(string: endpoint) else { return .failure(.invalidURL) }
        let request = URLRequest(url: url)
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse, (200...300) ~= response.statusCode else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode
                return .failure(.invalidResponse(code: statusCode!))
            }
            let decoder = JSONDecoder()
            guard let result = try? decoder.decode(T.self, from: data) else {
                return .failure(.unableToDecode)
            }
            return .success(result)
        } catch {
            return .failure(.customError(error))
        }
        return nil
    }
}
