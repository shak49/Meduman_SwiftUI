//
//  ArticleService.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 3/14/24.
//

import Foundation


enum GenderType: String {
    case female = "Female"
    case male = "Male"
    
    var value: String { rawValue }
}

final class ArticleService {
    //MARK: - Properties
    static let shared = ArticleService()
    
    //MARK: - Lifecycles
    private init() {}
    
    //MARK: - Functions
    func getArticles(age: Int, sex: GenderType) {
        let queries = [
            URLQueryItem(name: "age", value: "\(age)"),
            URLQueryItem(name: "sex", value: "\(sex)")
        ]
        guard let url = EndpointBuilder.shared.build(queries: queries) else { return }
        Task {
            var request = URLRequest(url: url)
            await NetworkClient.shared.request(request: request, type: CustomResponse.self)
        }
    }
}
