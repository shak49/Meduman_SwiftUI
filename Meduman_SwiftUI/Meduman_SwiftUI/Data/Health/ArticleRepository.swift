//
//  ArticleRepository.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 3/31/23.
//

import Foundation
import Combine


protocol ArticleRepositoryProtocol {
    //MARK: - Properties
    var session: URLSessionProtocol? { get }
    
    //MARK: - Lifecycles
    init(session: URLSessionProtocol?)
    
    //MARK: - Functions
    func fetchArticles(queryItems: [URLQueryItem]?) async -> AnyPublisher<[Article]?, NetworkError>?
}

class ArticleRepository: ArticleRepositoryProtocol {
    //MARK: - Properties
    var session: URLSessionProtocol?
    
    //MARK: - Lifecycles
    required init(session: URLSessionProtocol?) {
        self.session = session
    }
    
    //MARK: - Functions
    func fetchArticles(queryItems: [URLQueryItem]?) async -> AnyPublisher<[Article]?, NetworkError>? {
        guard let queryItems = queryItems else {
            return nil }
        guard let url = Constructor.shared.url(scheme: "https", host: "health.gov", path: "/v3/itemlist.json", queryItems: queryItems, token: nil, headerField: nil) else {
            return Fail(error: .badUrl)
                .eraseToAnyPublisher()
        }
        return self.session?.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Result.self, decoder: JSONDecoder())
            .map(\.item?.articles)
            .map({ articles in
                return articles
            })
            .mapError({ error -> NetworkError in
                return .invalidServerResponse
            })
            .eraseToAnyPublisher()
    }
}
