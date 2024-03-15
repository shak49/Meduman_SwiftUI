//
//  APIBuilder.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 3/14/24.
//

import Foundation

//https://health.gov/myhealthfinder/api/v3/myhealthfinder.json
final class URLEndpointBuilder {
    //MARK: - Properties
    static var shared = URLEndpointBuilder()
    
    //MARK: - Lifecycles
    private init() {}
    
    //MARK: - Functions
    func build(queries: [URLQueryItem]) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "health.go"
        urlComponents.path = "/myhealthfinder/api/v3/myhealthfinder.json"
        urlComponents.queryItems = queries
        guard let url = urlComponents.url else { return nil }
        return url
    }
}
