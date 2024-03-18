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
    private let endpoint = EndpointBuilder.shared
    private let client = NetworkClient.shared
    
    //MARK: - Lifecycles
    private init() {}
    
    //MARK: - Functions
    func getArticles(age: String, sex: String) async -> Result<[Article], NetworkClient.NetworkError> {
        let queries = [
            URLQueryItem(name: "age", value: age),
            URLQueryItem(name: "sex", value: sex)
        ]
        let url = EndpointBuilder.shared.build(host: "health.gov", path: "/myhealthfinder/api/v3/myhealthfinder.json", queries: queries)
        let result = await client.request(url: url, type: ArticleResponseData.self)
        switch result {
        case .success(let response):
            let articles = response.responseData.resource.all.articles
            return .success(articles)
        case .failure(let error):
            return .failure(error)
        }
    }
}
