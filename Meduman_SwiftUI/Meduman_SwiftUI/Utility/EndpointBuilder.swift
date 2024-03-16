//
//  APIBuilder.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 3/14/24.
//

import Foundation


// https://health.gov/myhealthfinder/api/v3/myhealthfinder.json

final class EndpointBuilder {
    //MARK: - Properties
    static var shared = EndpointBuilder()
    
    //MARK: - Lifecycles
    private init() {}
    
    //MARK: - Functions
    func build(age: String, sex: String) -> URL? {
        var urlComponents = URLComponents()
        let queries = [
            URLQueryItem(name: "age", value: age),
            URLQueryItem(name: "sex", value: sex)
        ]
        urlComponents.scheme = "https"
        urlComponents.host = "health.go"
        urlComponents.path = "/myhealthfinder/api/v3/myhealthfinder.json"
        urlComponents.queryItems = queries
        guard let url = urlComponents.url else { return nil }
        return url
    }
}
