//
//  ArticleService.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 3/14/24.
//

import Foundation

final class ArticleService {
    //MARK: - Properties
    private let client: NetworkClientProtocol!
    
    //MARK: - Lifecycles
    init(client: NetworkClientProtocol = NetworkClient(session: .shared)) {
        self.client = client
    }
    
    //MARK: - Functions
    func getArticles(age: String, sex: String) async -> Result<[Article], ArticleError> {
        do {
            let result = try await client.request(endpoint: .articles(age: age, sex: sex), type: ArticleResponse.self)
            let articles = result.responseData.resource.all.articles
            return .success(articles)
        } catch {
            return .failure(.unableToFetchArticles(error: error))
        }
    }
}

extension ArticleService {
    enum ArticleError: LocalizedError {
        case unableToFetchArticles(error: Error)
        
        var errorDescription: String? {
            switch self {
            case .unableToFetchArticles(let error):
                return "Unable to fetch articles. Error: \(error.localizedDescription)!"
            }
        }
    }
}
