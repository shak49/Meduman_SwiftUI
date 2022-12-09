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
    func requestAuthorization() -> Future<Bool, HKError>
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
    let allTypes = Set([
        HKObjectType.quantityType(forIdentifier: .bloodGlucose)!,
        HKObjectType.quantityType(forIdentifier: .heartRate)!,
        HKObjectType.characteristicType(forIdentifier: .dateOfBirth)!,
        //HKObjectType.clinicalType(forIdentifier: .labResultRecord)!
    ])
    
    //MARK: - Lifecycles
    required init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }
    
    //MARK: - Functions
    func requestAuthorization() -> Future<Bool, HKError> {
        Future { [weak self] promise in
            self?.healthStore?.requestAuthorization(toShare: self?.allTypes as? Set<HKSampleType>, read: self?.allTypes, completion: { success, error in
                guard error == nil else {
                    print("Request Auth Error: \(error)")
                    promise(.failure(.unableToAuthorizeAccess))
                    return
                }
                print(success)
                promise(.success(success))
            })
        }
    }
}
