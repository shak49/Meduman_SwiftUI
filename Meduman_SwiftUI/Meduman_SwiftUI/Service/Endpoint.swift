//
//  Endpoint.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 3/18/24.
//

import Foundation

// https://health.gov/myhealthfinder/api/v3/myhealthfinder.json?age=29&sex=male
enum Endpoint {
    case articles(age: String, sex: String)
}

extension Endpoint {
    var scheme: String { "https" }
    var host: String { "health.gov" }
    var path: String {
        switch self {
        case .articles:
            return "/myhealthfinder/api/v3/myhealthfinder.json"
        }
    }
    var queryItems: [URLQueryItem] {
        switch self {
        case .articles(let age, let sex):
            return [
                URLQueryItem(name: "age", value: age),
                URLQueryItem(name: "sex", value: sex)
            ]
        }
    }
}

extension Endpoint {
    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = queryItems
        return urlComponents.url
    }
}
