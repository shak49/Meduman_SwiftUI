//
//  HealthStoreMock.swift
//  Meduman_SwiftUITests
//
//  Created by Shak Feizi on 11/20/22.
//

import HealthKit
@testable import Meduman_SwiftUI


class HealthStoreMock: HKHealthStore {
    //MARK: - Properties
    var invokedRequestAuthorization = false
    var invokedRequestAuthorizationCount = 0
    var invokedRequestAuthorizationParameters: (typesToShare: Set<HKSampleType>?, typesToRead: Set<HKObjectType>?)?
    var invokedRequestAuthorizationParametersList = [(typesToShare: Set<HKSampleType>?, typesToRead: Set<HKObjectType>?)]()
    var stubbedRequestAuthorizationCompletionResult: (Bool, Error?)?

    //MARK: - Functions
    override func requestAuthorization(toShare typesToShare: Set<HKSampleType>?, read typesToRead: Set<HKObjectType>?, completion: @escaping (Bool, Error?) -> Void) {
        invokedRequestAuthorization = true
        invokedRequestAuthorizationCount += 1
        invokedRequestAuthorizationParameters = (typesToShare, typesToRead)
        invokedRequestAuthorizationParametersList.append((typesToShare, typesToRead))
        if let result = stubbedRequestAuthorizationCompletionResult {
            print("RESULT: \(result)")
            completion(result.0, result.1)
        }
    }
}
