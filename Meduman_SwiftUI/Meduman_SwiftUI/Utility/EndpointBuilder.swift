//
//  APIBuilder.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 3/14/24.
//

import Foundation


// https://health.gov/myhealthfinder/api/v3/myhealthfinder.json?age=29&sex=male

final class EndpointBuilder {
    //MARK: - Properties
    static var shared = EndpointBuilder()
    
    //MARK: - Lifecycles
    private init() {}
    
    //MARK: - Functions
    func build(host: String, path: String, queries: [URLQueryItem]) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = queries
        guard let url = urlComponents.url else { return nil }
        return url
    }
}
