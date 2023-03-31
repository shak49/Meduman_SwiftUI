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
    var sessionMock: URLSessionMock?
    var sut: ArticleRepository?
    
    //MARK: - Lifecycles
    override func setUpWithError() throws {
        try super.setUpWithError()
        self.sessionMock = URLSessionMock()
        self.sut = ArticleRepository(session: sessionMock)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        self.sut = nil
    }

    //MARK: - Functions
    func test_articlesUrl_validUrl() {
        
    }
}
