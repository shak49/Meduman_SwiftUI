//
//  HealthRepository.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 9/28/22.
//

import HealthKit
import Combine


protocol HealthRepoProtocol {
    //MARK: - Properties
    var healthStore: HKHealthStore? { get }
//    var healthQuary: HKSampleQuery? { get }
//    var healthTypes: Set<HKObjectType> { get }
    
    //MARK: - Lifecycles
    init(healthStore: HKHealthStore)
    
    //MARK: - Functions
    func requestAuthorization(completion: @escaping(Result<Bool, HealthError>) -> Void)
//    func requestAuthorization() -> Future<Bool, HealthError>
//    func writeCharacteristicTypeSample()
//    func readCharacteristicTypeSample()
//    func writeQuantityTypeSample()
//    func readQuantityTypeSample()
//    func writeCategoryTypeSample()
//    func readCategoryTypeSample()
}


class HealthRepository: HealthRepoProtocol {
    //MARK: - Properties
    var healthStore: HKHealthStore?
    var allTypes: Set<HKSampleType> = []
    
    //MARK: - Lifecycles
    required init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }
    
    //MARK: - Functions
    func requestAuthorization(completion: @escaping (Result<Bool, HealthError>) -> Void) {
        self.healthStore?.requestAuthorization(toShare: self.allTypes, read: self.allTypes, completion: { authorized, error in
            if error != nil {
                print("ERROR: \(error)")
                completion(.failure(.unableToAuthorizeAccess))
            }
            if authorized {
                completion(.success(true))
            }
        })
    }
}
