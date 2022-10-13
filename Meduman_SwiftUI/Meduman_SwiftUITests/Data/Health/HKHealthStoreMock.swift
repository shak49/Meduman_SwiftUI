//
//  HKHealthStoreMock.swift
//  Meduman_SwiftUITests
//
//  Created by Shak Feizi on 10/12/22.
//

import HealthKit
@testable import Meduman_SwiftUI


protocol HKHealthStoreProtocol {
    //MARK: - Properties
    var hasAccess: Bool? { get }
    
    //MARK: - Functions
    func requestAccess(completion: (@escaping(Result<Bool, Error>) -> Void))
    func save(session: Health, completion: (@escaping(Result<Bool, Error>) -> Void))
    func loadSessions(completion: (@escaping(Result<[Health], Error>) -> Void))
}

class HKHealthStoreMock: HKHealthStore, HKHealthStoreProtocol {
    //MARK: - Properties
    var hasAccess: Bool?
    
    //MARK: - Functions
    func requestAccess(completion: @escaping ((Result<Bool, Error>) -> Void)) {
        <#code#>
    }
    
    func save(session: Health, completion: @escaping ((Result<Bool, Error>) -> Void)) {
        <#code#>
    }
    
    func loadSessions(completion: @escaping ((Result<[Health], Error>) -> Void)) {
        <#code#>
    }
}
