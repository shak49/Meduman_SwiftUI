//
//  NetworkClientTests.swift
//  Meduman_SwiftUITests
//
//  Created by Shak Feizi on 3/28/24.
//

import XCTest
@testable import Meduman_SwiftUI

final class NetworkClientTests: XCTestCase {
    //MARK: - Properties
    private var url: URL!
    private var session: URLSession!
    private var service: NetworkClientProtocol!
    
    //MARK: - Lifecycles
    override func setUp() {
        url = URL(string: "https://health.gov/myhealthfinder/api/v3/myhealthfinder.json?age=66&sex=male")
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLSessionProtocolMock.self]
        session = URLSession(configuration: configuration)
        service = NetworkClient(session: session)
    }
    
    override func tearDown() {
        url = nil
        session = nil
        service = nil
    }
    
    //MARK: - Properties
    func test_request_withSuccess_returnValidResponse() async throws {
        guard let path = Bundle.main.path(forResource: "ArticleResponse", ofType: "json"), let data = FileManager.default.contents(atPath: path) else {
            XCTFail("Failed to get the static json file")
            return
        }
        URLSessionProtocolMock.loadingHandler = {
            let response = HTTPURLResponse(url: self.url, statusCode: 200, httpVersion: nil, headerFields: nil)
            return (response!, data)
        }
        let result = try await service.request(endpoint: .articles(age: "65", sex: "male"), type: ArticleResponse.self)
        let staticJson = try StaticJSONMapper.decode(file: "ArticleResponse", type: ArticleResponse.self)
        XCTAssertEqual(result, staticJson, "These result must be the same as static json")
    }
}
