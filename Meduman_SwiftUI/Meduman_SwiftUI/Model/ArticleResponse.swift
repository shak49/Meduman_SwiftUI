//
//  ArticleResponse.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 3/15/24.
//

import Foundation


struct ArticleResponse: Codable, Equatable {
    let responseData: ResponseData
    
    enum CodingKeys: String, CodingKey {
        case responseData = "Result"
    }
}

struct ResponseData: Codable, Equatable {
    let resource: Resource
    
    enum CodingKeys: String, CodingKey {
        case resource = "Resources"
    }
}

struct Resource: Codable, Equatable {
    let all: All
}

struct All: Codable, Equatable {
    let articles: [Article]
    
    enum CodingKeys: String, CodingKey {
        case articles = "Resource"
    }
}

struct Article: Codable, Identifiable, Equatable {
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

struct Section: Codable, Equatable {
    let paragraphs: [Paragraph]?
    
    enum CodingKeys: String, CodingKey {
        case paragraphs = "section"
    }
}

struct Paragraph: Codable, Identifiable, Equatable {
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

extension ArticleResponse {
    static func == (lhs: ArticleResponse, rhs: ArticleResponse) -> Bool {
        return lhs.responseData == rhs.responseData
    }
}

extension ResponseData {
    static func == (lhs: ResponseData, rhs: ResponseData) -> Bool {
        return lhs.resource == rhs.resource
    }
}

extension Resource {
    static func == (lhs: Resource, rhs: Resource) -> Bool {
        return lhs.all == rhs.all
    }
}

extension All {
    static func == (lhs: All, rhs: All) -> Bool {
        return lhs.articles == rhs.articles
    }
}

extension Article {
    static func == (lhs: Article, rhs: Article) -> Bool {
        switch (lhs, rhs) {
        case (let lhsIdValue, let rhsIdValue):
            return lhsIdValue.id == rhsIdValue.id
        case (let lhsTitleValue, let rhsTitleValue):
            return lhsTitleValue.title == rhsTitleValue.title
        case (let lhsImageValue, let rhsImageValue):
            return lhsImageValue.imageString == rhsImageValue.imageString
        case (let lhsSectionValue, let rhsSectionValue):
            return lhsSectionValue.section == rhsSectionValue.section
        }
    }
}

extension Section {
    static func == (lhs: Section, rhs: Section) -> Bool {
        return lhs.paragraphs == rhs.paragraphs
    }
}

extension Paragraph {
    static func == (lhs: Paragraph, rhs: Paragraph) -> Bool {
        return lhs.content == rhs.content
    }
}

extension String {
    func htmlToString() -> String {
        return  try! NSAttributedString(data: self.data(using: .utf8)!, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil).string
    }
}
