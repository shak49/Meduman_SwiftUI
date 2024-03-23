//
//  ArticleService.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 3/14/24.
//

import Foundation


final class ArticleService {
    //MARK: - Properties
    static let shared = ArticleService()
    private let client = NetworkClient.shared
    
    //MARK: - Lifecycles
    private init() {}
    
    //MARK: - Functions
    func getArticles(age: String, sex: String) async -> Result<[Article], NetworkClient.NetworkError> {
        let result = await client.request(endpoint: .articles(age: age, sex: sex), type: FirstLevelResponse.self)
        switch result {
        case .success(let response):
            let articles = response.responseData.resource.all.articles
            return .success(articles)
        case .failure(let error):
            return .failure(error)
        }
    }
}
