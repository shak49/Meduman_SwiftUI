//
//  HKHealthStoreMock.swift
//  Meduman_SwiftUITests
//
//  Created by Shak Feizi on 10/12/22.
//

import HealthKit


class HKHealthStoreMock: HKHealthStore {
    //MARK: - Properties
    let result: Bool?
    let error: Error?
    
    //MARK: - Lifecycles
    init(result: Bool?, error: Error?) {
        self.result = result
        self.error = error
    }
    
    //MARK: - Functions
    func requestAuthorization(toShare typesToShare: Set<HKSampleType>?, read typesToRead: Set<HKObjectType>?, completion: @escaping (Bool?, Error?) -> Void) {
        let result = self.result
        let error = self.error
        if typesToShare != nil, typesToRead != nil {
            completion(result!, nil)
        } else {
            completion(nil, error)
        }
    }
    
    func save(_ objects: [HKObject], withCompletion completion: @escaping (Bool?, Error?) -> Void) {
        let result = self.result
        let error = self.error
        if objects != nil {
            completion(result!, nil)
        } else {
            completion(nil, error)
        }
    }
}
