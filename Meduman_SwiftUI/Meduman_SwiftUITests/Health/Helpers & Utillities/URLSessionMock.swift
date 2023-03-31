//
//  URLSessionMock.swift
//  Meduman_SwiftUITests
//
//  Created by Shak Feizi on 3/31/23.
//

import Foundation


struct Response {
    var data: Data?
    var response: URLResponse?
    var error: Error?

    init(data: Data?, response: URLResponse?, error: Error?) {
        self.data = data
        self.response = response
        self.error = error
    }
}

class URLSessionMock: URLSession {
    typealias CompletionHandler = ((Data?, URLResponse?, Error?) -> Void)
    
    //MARK: - Properties
    var data: Data?
    var response: URLResponse?
    var error: Error?
    var completionHandler: CompletionHandler?
    override static var shared: URLSession {
        return URLSessionMock()
    }
    
    //MARK: - Lifecycles
    
    //MARK: - Functions
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let data = self.data
        let response = self.response
        let error = self.error
        completionHandler(data, response, error)
        return URLSessionDataTaskMock(mockResponse: Response(data: data, response: response, error: error), completionHandler: completionHandler)
    }
}

class URLSessionDataTaskMock: URLSessionDataTask {
    typealias CompletionHandler = ((Data?, URLResponse?, Error?) -> Void)
    
    //MARK: - Properties
    var mockResponse: Response
    var completionHandler: CompletionHandler
    
    //MARK: - Lifecycles
    init(mockResponse: Response, completionHandler: @escaping CompletionHandler) {
        self.mockResponse = mockResponse
        self.completionHandler = completionHandler
    }
    
    //MARK: - Functions
    override func resume() {
        self.completionHandler(self.mockResponse.data, self.mockResponse.response, self.mockResponse.error)
    }
}
