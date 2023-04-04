//
//  ArticlesUnitTests.swift
//  Meduman_SwiftUITests
//
//  Created by Shak Feizi on 3/28/23.
//

@testable import Meduman_SwiftUI
import Foundation
import XCTest


class ArticlesUnitTests: XCTestCase {
    //MARK: - Properties
    var session: SessionMock?
    var sut: ArticleRepository?
    
    //MARK: - Lifecycles
    override func setUpWithError() throws {
        try super.setUpWithError()
        self.session = SessionMock()
        self.sut = ArticleRepository(session: self.session)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        self.sut = nil
    }

    //MARK: - Functions
    func test_fetchArticles_successfullyReturnArticles() async {
        let expectation = expectation(description: "\'fetchArticles\' successfully returns articles.")
        
        wait(for: [expectation], timeout: 2)
    }
    
}
