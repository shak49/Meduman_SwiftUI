//
//  DataTaskPublisher.swift
//  Meduman_SwiftUITests
//
//  Created by Shak Feizi on 4/9/23.
//

import Foundation
import Combine
import Mockingbird


protocol URLSessionProtocol {
    
    func dataTaskPublisher(for: URLRequest) -> URLSession.DataTaskPublisher
}

protocol URLSessionDataTaskPublisherProtocol {
    
    func receive<S>(
        on scheduler: S,
        options: S.SchedulerOptions?
    ) -> Publishers.ReceiveOn<URLSession.DataTaskPublisher, S> where S : Scheduler
    
    func map<T>(_ transform: @escaping ((data: Data, response: URLResponse)) -> T) -> Publishers.Map<URLSession.DataTaskPublisher, T>
    
    func mapError<E>(_ transform: @escaping (URLError) -> E) -> Publishers.MapError<URLSession.DataTaskPublisher, E> where E : Error
    
    func sink(receiveCompletion: @escaping ((Subscribers.Completion<URLError>) -> Void), receiveValue: @escaping (((data: Data, response: URLResponse)) -> Void)) -> AnyCancellable
}

extension URLSession: URLSessionProtocol, AnyMockable {}
extension URLSession.DataTaskPublisher: URLSessionDataTaskPublisherProtocol, AnyMockable {}
