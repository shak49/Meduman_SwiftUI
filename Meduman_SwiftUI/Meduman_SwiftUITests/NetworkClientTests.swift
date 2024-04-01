//
//  NetworkClientTests.swift
//  Meduman_SwiftUITests
//
//  Created by Shak Feizi on 3/30/24.
//

import XCTest
@testable import Meduman_SwiftUI

final class NetworkClientTests: XCTestCase {
    //MARK: - Properties
    var url: URL!
    var session: URLSession!
    var client: NetworkClientProtocol!
    let age = "66"
    let sex = "Male"
    
    //MARK: - Lifecycles
    override func setUp() {
        url = Endpoint.articles(age: age, sex: sex).url
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLSessionProtocolMock.self]
        session = URLSession(configuration: configuration)
        client = NetworkClient(session: session)
    }
    
    override func tearDown() {
        url = nil
        session = nil
        client = nil
    }
    
    //MARK: - Tests
    func test_request_successful_withValidResponse() async throws {
        
    }
    
    func test_request_successful_whereResponseIsValid() async throws {
        guard let path = Bundle.main.path(forResource: "ArticleResponse", ofType: "json"), var data = FileManager.default.contents(atPath: path) else {
            XCTFail("Failed to get static users file")
            return
        }
        URLSessionProtocolMock.loadingHandler = {
            let response = HTTPURLResponse(url: self.url, statusCode: 200, httpVersion: nil, headerFields: nil)
            return (response!, data)
        }
        let result = try await client.request(endpoint: .articles(age: age, sex: sex), type: ArticleResponse.self)
        let staticJSON = try StaticJSONMapper.decode(file: "ArticleResponse", type: ArticleResponse.self)
        XCTAssertEqual(result, staticJSON, "")
    }
}
