//
//  ArticleResponseData.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 3/15/24.
//

import Foundation


struct ArticleResponseData: Codable {
    let responseData: ResponseData
    
    enum CodingKeys: String, CodingKey {
        case responseData = "Result"
    }
}

struct ResponseData: Codable {
    let resource: Resource
    
    enum CodingKeys: String, CodingKey {
        case resource = "Resources"
    }
}

struct Resource: Codable {
    let all: All
}

struct All: Codable {
    let articles: [Article]
    
    enum CodingKeys: String, CodingKey {
        case articles = "Resource"
    }
}

struct Article: Codable {
    let id: String?
    let title: String?
    let imageUrl: String?
}
