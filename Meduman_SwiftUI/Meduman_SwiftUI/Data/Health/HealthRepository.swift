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
    //var healthTypes: Set<HKSampleType> { get }
    
    //MARK: - Functions
    func requestAuthorization() -> Future<Bool, HealthError>
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
    let healthTypes = Set([
        HKSampleType.quantityType(forIdentifier: .bloodGlucose)!,
        HKSampleType.quantityType(forIdentifier: .heartRate)!
    ])
    
    //MARK: - Functions
    func requestAuthorization() -> Future<Bool, HealthError> {
        Future { [unowned self] promise in
            self.healthStore?.requestAuthorization(toShare: healthTypes, read: healthTypes, completion: { authorized, error in
                guard error == nil else {
                    print("HEALTHKIT AUTHORIZATION ERROR: ", error?.localizedDescription)
                    promise(.failure(.unableToAuthorize))
                    return
                }
                print("Authorized: \(authorized)")
                promise(.success(authorized))
            })
        }
    }
}
