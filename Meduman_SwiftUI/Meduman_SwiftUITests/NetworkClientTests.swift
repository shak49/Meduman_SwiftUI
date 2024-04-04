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
        guard let path = Bundle.main.path(forResource: "ArticleResponse", ofType: "json"), let data = FileManager.default.contents(atPath: path) else {
            XCTFail("Failed to get static article file")
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
    
    func test_request_unsuccessful_withInvalidStatusCodeAndRange() async {
        let statusCode = 400
        URLSessionProtocolMock.loadingHandler = {
            let response = HTTPURLResponse(url: self.url, statusCode: statusCode, httpVersion: nil, headerFields: nil)
            return (response!, nil)
        }
        do {
            _ = try await client.request(endpoint: .articles(age: age, sex: sex), type: ArticleResponse.self)
        } catch {
            guard let networkError = error as? NetworkClient.NetworkError else {
                XCTFail("Got the wrong type of error, expecting error of type NetworkError")
                return
            }
            let staticStatusCode = NetworkClient.NetworkError.invalidResponse(code: statusCode)
            XCTAssertEqual(networkError, staticStatusCode, "Error should be a network error which throws invalid status code")
        }
    }
}
