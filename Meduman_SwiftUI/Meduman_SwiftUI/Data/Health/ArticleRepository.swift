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
    var session: URLSession? { get }
    
    //MARK: - Lifecycles
    init(session: URLSession?)
    
    //MARK: - Functions
    func fetchArticles(queryItems: [URLQueryItem]?) async -> AnyPublisher<[Article]?, NetworkError>?
}

class ArticleRepository: ArticleRepositoryProtocol {
    //MARK: - Properties
    var session: URLSession?
    
    //MARK: - Lifecycles
    required init(session: URLSession? = .shared) {
        self.session = session
    }
    
    //MARK: - Functions
    func fetchArticles(queryItems: [URLQueryItem]?) async -> AnyPublisher<[Article]?, NetworkError>? {
        guard let queryItems = queryItems else {
            return nil }
        guard let url = URL(string: Constraint.shared.localizedString(key: "Articles") + "Type=topic&Lang=en&Lang=en") else {
            return Fail(error: .badUrl)
                .eraseToAnyPublisher()
        }
        let request = URLRequest(url: url)
        return self.session?.dataTaskPublisher(for: request)
            //.receive(on: DispatchQueue.main)
            .map(\.data)
            .decode(type: Result.self, decoder: JSONDecoder())
            .mapError({ error -> NetworkError in
                return .unableToDecode
            })
            .map(\.item?.articles)
            .map({ articles in
                print(articles)
                return articles
            })
            .mapError({ error -> NetworkError in
                return .invalidServerResponse
            })
            .eraseToAnyPublisher()
    }
}
