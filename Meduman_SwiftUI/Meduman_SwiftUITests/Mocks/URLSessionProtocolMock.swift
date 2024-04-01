//
//  URLSessionProtocolMock.swift
//  Meduman_SwiftUITests
//
//  Created by Shak Feizi on 3/30/24.
//

#if DEBUG
import Foundation

final class URLSessionProtocolMock: URLProtocol {
    //MARK: - Properties
    static var loadingHandler: (() -> (HTTPURLResponse, Data?))?
    
    //MARK: - Lifecycles
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        guard let handler = URLSessionProtocolMock.loadingHandler else {
            fatalError("Loading handler is not set")
        }
        let (response, data) = handler()
        client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        if let data = data {
            client?.urlProtocol(self, didLoad: data)
        }
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {}
}
#endif
