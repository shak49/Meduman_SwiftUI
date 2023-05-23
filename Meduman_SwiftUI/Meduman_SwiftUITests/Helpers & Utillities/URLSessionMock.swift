//
//  URLSessionMock.swift
//  Meduman_SwiftUITests
//
//  Created by Shak Feizi on 4/14/23.
//

import Foundation
import Combine


class URLSessionMock: URLSession {
    //MARK: - Properties
    var data: Data?
    var response: URLResponse?
    var error: Error?
    
    //MARK: - Lifecycles

    //MARK: - Functions
    func dataTaskPublisher(for request: URLRequest) -> URLSessionMock.DataTaskPublisherMock {
        let data = self.data
        let response = self.response
        let error = self.error
        return URLSessionMock.DataTaskPublisherMock(data: data, response: response, error: error)
    }
}

extension URLSessionMock {
    class DataTaskPublisherMock {
        //MARK: - Properties
        let data: Data?
        let response: URLResponse?
        let error: Error?
        
        //MARK: - Lifecycles
        init(data: Data?, response: URLResponse?, error: Error?) {
            self.data = data
            self.response = response
            self.error = error
        }
        
        //MARK: - Functions
        func publisher(for request: URLRequest) -> AnyPublisher<Data, Error> {
            if let error = error {
                return Fail(error: error).eraseToAnyPublisher()
            }
            guard let data = data, let response = response else {
                return Fail(error: URLError(.badServerResponse)).eraseToAnyPublisher()
            }
            return Just(data)
                .setFailureType(to: Error.self)
                .tryMap { data in
                    guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                        throw URLError(.badServerResponse)
                    }
                    return data
                }
                .eraseToAnyPublisher()
        }
    }
}
