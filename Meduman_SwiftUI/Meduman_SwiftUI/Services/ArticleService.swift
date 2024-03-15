//
//  ArticleService.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 3/14/24.
//

import Foundation


enum HTTPMethod: String {
    case GET
    case POST
}

enum GenderType: String {
    case female = "Female"
    case male = "Male"
}

final class ArticleService {
    //MARK: - Properties
    static let shared = ArticleService()
    
    //MARK: - Lifecycles
    private init() {}
    
    //MARK: - Functions
    func getArticles(age: Int, sex: GenderType, method: HTTPMethod) {
        let queries = [
            URLQueryItem(name: "age", value: "\(age)"),
            URLQueryItem(name: "sex", value: "\(sex)")
        ]
        guard let url = URLEndpointBuilder.shared.build(queries: queries) else { return }
        Task {
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            await NetworkClient.shared.request(request: request, type: CustomResponse.self)
        }
    }
}