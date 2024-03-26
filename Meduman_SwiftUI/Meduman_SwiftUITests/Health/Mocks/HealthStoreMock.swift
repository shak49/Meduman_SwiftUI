//
//  HealthStoreMock.swift
//  Meduman_SwiftUITests
//
//  Created by Shak Feizi on 12/12/22.
//

import HealthKit


class HealthStoreMock: HKHealthStore {
    //MARK: - Properties
    var success: Bool?
    var error: Error?
    
    //MARK: - Functions
    func requestAuthorization(toShare typesToShare: Set<HKSampleType>?, read typesToRead: Set<HKObjectType>?, completion: @escaping (Bool?, Error?) -> Void) {
        if typesToShare != nil || typesToRead != nil {
            let success = self.success
            let error = self.error
            completion(success, error)
        }
    }
    
    func save(_ object: HKObject, withCompletion completion: @escaping (Bool?, Error?) -> Void) {
        let success = self.success
        let error = self.error
        completion(success, error)
    }
    
    func delete(_ object: HKObject, withCompletion completion: @escaping (Bool?, Error?) -> Void) {
        let success = self.success
        let error = self.error
        completion(success, error)
    }
    
}
