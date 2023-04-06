//
//  ArticleRepository.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 3/31/23.
//

import Foundation
import Combine
import Alamofire


protocol ArticleRepositoryProtocol {
    //MARK: - Properties
    
    //MARK: - Lifecycles
    
    //MARK: - Functions
    //func fetchArticles(queryItems: [URLQueryItem]?) async -> AnyPublisher<[Article]?, NetworkError>?
}


class ArticleRepository: ArticleRepositoryProtocol {
    //MARK: - Properties
    
    //MARK: - Lifecycles
    
    //MARK: - Functions
//    func fetchArticles(queryItems: [URLQueryItem]?) async -> AnyPublisher<[Article]?, NetworkError>? {
//        let subject = PassthroughSubject<[Article]?, NetworkError>()
//        guard let queryItems = queryItems else {
//            return nil }
//        guard let url = Constructor.shared.url(scheme: "https", host: "health.gov", path: "/v3/itemlist.json", queryItems: queryItems, token: nil, headerField: nil) else {
//            subject.send(completion: .failure(.badUrl))
//            return nil
//        }
//
//    }
}
