//
//  ArticlesUnitTests.swift
//  Meduman_SwiftUITests
//
//  Created by Shak Feizi on 3/28/23.
//

@testable import Meduman_SwiftUI
import XCTest
import Combine
import Mockingbird


class ArticlesUnitTests: XCTestCase {
    //MARK: - Properties
    var sessionMock: URLSession?
    var sut: ArticleRepository?
    
    //MARK: - Lifecycles
    override func setUpWithError() throws {
        try super.setUpWithError()
        self.sessionMock = mock(URLSession.self)
        self.sut = ArticleRepository(session: self.sessionMock)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        self.sut = nil
    }

    //MARK: - Functions
    func test_fetchArticles_successfullyReturnArticles() async {
        let expectation = expectation(description: "\'fetchArticles\' successfully returns articles.")
        var queryItems = [
            URLQueryItem(name: "Type", value: "topic"),
            URLQueryItem(name: "Lang", value: "en"),
            URLQueryItem(name: "Lang", value: "en"),
        ]
        let articles = try await self.sut?.fetchArticles(queryItems: queryItems)
            .flatMap({ articles in
                expectation.fulfill()
                XCTAssertNotNil(articles)
            })
        wait(for: [expectation], timeout: 2)
    }
    
}
