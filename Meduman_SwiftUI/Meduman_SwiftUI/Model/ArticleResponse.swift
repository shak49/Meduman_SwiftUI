//
//  ArticleResponse.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 3/15/24.
//

import Foundation


struct ArticleResponse: Codable {
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

struct Article: Codable, Identifiable {
    let id: String
    let title: String?
    let imageString: String?
    let section: Section?
    var image: URL? {
        guard let urlString = imageString else { return nil }
        return URL(string: urlString)
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case title = "Title"
        case imageString = "ImageUrl"
        case section = "Sections"
    }
}

struct Section: Codable {
    let paragraphs: [Paragraph]?
    
    enum CodingKeys: String, CodingKey {
        case paragraphs = "section"
    }
}

struct Paragraph: Codable, Identifiable {
    let id: String = UUID().uuidString
    let content: String?
    var body: String? {
        guard let content = content else { return nil }
        return content.htmlToString()
    }
    
    enum CodingKeys: String, CodingKey {
        case content = "Content"
    }
}

extension String {
    func htmlToString() -> String {
        return  try! NSAttributedString(data: self.data(using: .utf8)!, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil).string
    }
}
