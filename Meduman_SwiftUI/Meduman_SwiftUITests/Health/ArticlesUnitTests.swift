//
//  ArticlesUnitTests.swift
//  Meduman_SwiftUITests
//
//  Created by Shak Feizi on 3/28/23.
//

@testable import Meduman_SwiftUI
import XCTest
import Combine


class ArticlesUnitTests: XCTestCase {
    //MARK: - Properties
    var sessionMock: URLSessionMock?
    var sut: ArticleRepository?
    var cancellables = Set<AnyCancellable>()
    
    //MARK: - Lifecycles
    override func setUpWithError() throws {
        try super.setUpWithError()
        self.sessionMock = URLSessionMock()
        self.sut = ArticleRepository(session: self.sessionMock)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        self.sut = nil
    }

    //MARK: - Functions
    func test_fetchArticles_successfullyReturnArticles() async {
        let expectation = expectation(description: "\'fetchArticles\' successfully returns articles")
        let queryItems = [
            URLQueryItem(name: "Type", value: "topic"),
            URLQueryItem(name: "Lang", value: "en"),
            URLQueryItem(name: "Lang", value: "en")
        ]
        await self.sut?.fetchArticles(queryItems: queryItems)?
            .receive(on: DispatchQueue.main)
            .map({ articles in
                print(articles)
                expectation.fulfill()
                XCTAssertNotNil(articles)
            })
            .eraseToAnyPublisher()
        wait(for: [expectation], timeout: 5)
    }
    
}
