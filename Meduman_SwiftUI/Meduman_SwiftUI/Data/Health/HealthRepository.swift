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
    func writeQuantityTypeSample(record: Double?) -> Future<Bool, HKError>
    //func readQuantityTypeSample()
//    func writeCharacteristicTypeSample()
//    func readCharacteristicTypeSample()
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
    ])
    
    //MARK: - Lifecycles
    required init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }
    
    //MARK: - Functions
    func requestAuthorization() -> Future<Bool, HKError> {
        Future { [weak self] promise in
            guard HKHealthStore.isHealthDataAvailable() else {
                promise(.failure(.unableToAccessRecordsForThisDevice))
                return
            }
            self?.healthStore?.requestAuthorization(toShare: self?.allTypes as? Set<HKSampleType>, read: self?.allTypes, completion: { success, error in
                guard error == nil else {
                    print("Request Auth Error: \(error)")
                    promise(.failure(.unableToAuthorizeAccess))
                    return
                }
                print("SUCCESS: \(success)")
                promise(.success(success))
            })
        }
    }
    
    func writeQuantityTypeSample(record: Double?) -> Future<Bool, HKError> {
        Future { promise in
            if let record = record {
                guard let bloodGlucose = HKQuantityType.quantityType(forIdentifier: .bloodGlucose) else { return }
                let unit = HKUnit(from: "mg/dL")
                let quantity = HKQuantity(unit: unit, doubleValue: record)
                let sample = HKQuantitySample(type: bloodGlucose, quantity: quantity, start: Date(), end: Date())
                self.healthStore?.save([sample], withCompletion: { success, error in
                    guard error == nil else {
                        promise(.failure(.unableToWriteHealthRecord))
                        return
                    }
                    promise(.success(success))
                })
            }
        }
    }
}
