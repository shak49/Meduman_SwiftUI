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
    var sessionMock: URLSessionProtocol?
    var dataTaskPublisherMock: URLSessionDataTaskPublisherProtocol?
    var sut: ArticleRepository?
    private var cancellables = Set<AnyCancellable>()
    
    //MARK: - Lifecycles
    override func setUpWithError() throws {
        try super.setUpWithError()
        self.sessionMock = mock(URLSessionProtocol.self)
        self.dataTaskPublisherMock = mock(URLSessionDataTaskPublisherProtocol.self)
        self.sut = ArticleRepository(session: self.sessionMock)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        self.sut = nil
    }

    //MARK: - Functions
    func test_fetchArticles_successfullyReturnArticles() async {
        let expectation = expectation(description: "\'fetchArticles\' successfully returns articles.")
        let queryItems = [
            URLQueryItem(name: "Type", value: "topic"),
            URLQueryItem(name: "Lang", value: "en"),
            URLQueryItem(name: "Lang", value: "en")
        ]
        given(self.sessionMock?.dataTaskPublisher(for: any())).willThrow(NetworkError.invalidServerResponse)
        given(self.sessionMock?.dataTaskPublisher(for: any())).willReturn(self.dataTaskPublisherMock)
        await self.sut?.fetchArticles(queryItems: queryItems)?
            .sink(receiveCompletion: { completion in
                print(completion)
            }, receiveValue: { articles in
                guard let articles = articles else { return }
                expectation.fulfill()
                XCTAssertNotNil(articles)
            })
            .store(in: &self.cancellables)
        verify(self.sessionMock?.dataTaskPublisher(for: any())).wasCalled()
        verify(self.dataTaskPublisherMock?.sink(receiveCompletion: any(), receiveValue: any())).wasCalled()
        wait(for: [expectation], timeout: 5)
    }
    
}
