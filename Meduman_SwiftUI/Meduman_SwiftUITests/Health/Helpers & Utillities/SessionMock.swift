//
//  AlamofireMock.swift
//  Meduman_SwiftUITests
//
//  Created by Shak Feizi on 4/4/23.
//

import Foundation
import Alamofire


class SessionMock: Session {
    //MARK: - Properties
    
    //MARK: - Lifecycles
    
    //MARK: - Functions
    func request(_ convertible: URLRequestConvertible, interceptor: RequestInterceptor? = nil) -> DataRequestMock? {
        var underlyingQueue: DispatchQueue?
        var serializationQueue: DispatchQueue?
        var eventMonitor: EventMonitor?
        var delegate: RequestDelegate!
        return DataRequestMock(convertible: convertible, underlyingQueue: underlyingQueue, serializationQueue: serializationQueue, eventMonitor: eventMonitor, interceptor: interceptor, delegate: delegate)
    }
}

class DataRequestMock {
    //MARK: - Properties
    private var convertible: URLRequestConvertible?
    private var underlyingQueue: DispatchQueue?
    private var serializationQueue: DispatchQueue?
    private var eventMonitor: EventMonitor?
    private var interceptor: RequestInterceptor?
    private var delegate: RequestDelegate?
    var response: HTTPURLResponse?
    let url: URL!
    let statusCode: Int!
    let httpVersion: String?
    let headerFields: [String : String]?
    
    //MARK: - Lifecycles
    init(convertible: URLRequestConvertible?, underlyingQueue: DispatchQueue?, serializationQueue: DispatchQueue?, eventMonitor: EventMonitor?, interceptor: RequestInterceptor?, delegate: RequestDelegate) {
        self.convertible = convertible
        self.underlyingQueue = underlyingQueue
        self.serializationQueue = serializationQueue
        self.eventMonitor = eventMonitor
        self.interceptor = interceptor
        self.delegate = delegate
        self.url = URL(string: "")
        self.statusCode = 200
        self.httpVersion = nil
        self.headerFields = [:]
        self.response = HTTPURLResponse(url: self.url, statusCode: self.statusCode, httpVersion: self.httpVersion, headerFields: self.headerFields)
    }
    
    //MARK: - Functions

}
