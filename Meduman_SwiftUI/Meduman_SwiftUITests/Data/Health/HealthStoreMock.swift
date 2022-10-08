//
//  HealthStoreMock.swift
//  Meduman_SwiftUITests
//
//  Created by Shak Feizi on 10/3/22.
//

import HealthKit
import Combine

protocol HealthStoreMockProtocol {
    //MARK: - Properties
    
    //MARK: - Functions
    func requestAuthorization(toShare: Set<HKSampleType>?, read: Set<HKObjectType>?) -> AnyPublisher<Bool, Error>
    func save(_ of: HKObject) -> AnyPublisher<Bool, Error>
    func delete(_ of: HKObject) -> AnyPublisher<Bool, Error>
    
}

class HealthStoreMock: HKHealthStore, HealthStoreMockProtocol {
    //MARK: - Properties
    
    //MARK: - Functions
    func requestAuthorization(toShare: Set<HKSampleType>?, read: Set<HKObjectType>?) -> AnyPublisher<Bool, Error> {
        <#code#>
    }
    
    func save(_ of: HKObject) -> AnyPublisher<Bool, Error> {
        <#code#>
    }
    
    func delete(_ of: HKObject) -> AnyPublisher<Bool, Error> {
        <#code#>
    }
}
