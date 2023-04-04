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
    var session: Session? { get }
    
    //MARK: - Lifecycles
    init(session: Session?)
    
    //MARK: - Functions
    func fetchArticles() async -> AnyPublisher<[Article]?, NetworkError>
}


class ArticleRepository: ArticleRepositoryProtocol {
    //MARK: - Properties
    var session: Session?
    
    //MARK: - Lifecycles
    required init(session: Session?) {
        self.session = session
    }
    
    //MARK: - Functions
    func fetchArticles() async -> AnyPublisher<[Article]?, NetworkError> {
        let queryItems = [
            URLQueryItem(name: "Type", value: "topic"),
            URLQueryItem(name: "Lang", value: "en"),
            URLQueryItem(name: "Lang", value: "en")
        ]
        guard let url = Constructor.shared.url(scheme: "https", host: "health.gov", path: "/v3/itemlist.json", queryItems: queryItems, token: nil, headerField: nil) else { throw NetworkError.badUrl }
        
    }
}
