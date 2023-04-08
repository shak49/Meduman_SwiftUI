//
//  Article.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 4/3/23.
//

import Foundation


struct Result: Codable {
    enum CodingKeys: String, CodingKey {
        case item = "Items"
    }
    
    var item: Item?
}

struct Item: Codable {
    enum CodingKeys: String, CodingKey {
        case articles = "Item"
    }
    
    var articles: [Article]?
}

struct Article: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case title = "Title"
    }
    
    var id: String?
    var title: String
}
