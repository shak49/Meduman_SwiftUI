//
//  ArticleServiceSuccessTests.swift
//  Meduman_SwiftUITests
//
//  Created by Shak Feizi on 3/25/24.
//

import XCTest
@testable import Meduman_SwiftUI


final class ArticleServiceSuccessTests: XCTestCase {
    //MARK: - Properties
    private var client: NetworkClientProtocol!
    private var service: ArticleService!
    private var age = "66"
    private var sex = "Male"
    
    //MARK: - Lifecycles
    override func setUp() {
        client = NetworkClientArticleSuccessMock()
        service = ArticleService(client: client)
    }
    
    override func tearDown() {
        client = nil
        service = nil
    }
    
    //MARK: - Tests
    func test_getArticles_withSuccessfulResponse() async {
        let result = await service.getArticles(age: age, sex: sex)
        switch result {
        case .success(let articles):
            XCTAssertEqual(articles.count, 1, "Succesfully received single article in an array of articles")
        case .failure:
            break
        }
    }
}
