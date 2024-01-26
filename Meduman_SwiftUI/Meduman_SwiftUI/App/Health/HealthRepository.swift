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
    var healthQuery: HKSampleQuery? { get }
    
    //MARK: - Lifecycles
    
    //MARK: - Functions
    func requestAuthorization() -> Future<Bool, HealthError>
    func writeHealthRecord(object: HKObject?) -> Future<Bool, HealthError>
    func readHealthRecord(type: HKSampleType?) -> AnyPublisher<[HKQuantitySample]?, HealthError>
    func removeHealthRecord(object: HKObject?) -> Future<Bool, HealthError>
}


class HealthRepository: HealthRepoProtocol {
    //MARK: - Properties
    var healthStore: HKHealthStore?
    var healthQuery: HKSampleQuery?
    let allTypes: Set<HKSampleType> = Set([
        HKSampleType.quantityType(forIdentifier: .bloodGlucose)!,
        HKSampleType.quantityType(forIdentifier: .heartRate)!,
        HKSampleType.quantityType(forIdentifier: .bloodPressureSystolic)!
    ])
    
    //MARK: - Lifecycles
    
    //MARK: - Functions
    func requestAuthorization() -> Future<Bool, HealthError> {
        Future { [weak self] promise in
            self?.healthStore?.requestAuthorization(toShare: self?.allTypes, read: self?.allTypes, completion: { success, error in
                guard error == nil else {
                    promise(.failure(.unableToAuthorizeAccess))
                    return
                }
                promise(.success(success))
            })
        }
    }
    
    func writeHealthRecord(object: HKObject?) -> Future<Bool, HealthError> {
        Future { promise in
            guard let object = object else { return }
            self.healthStore?.save(object) { success, error in
                if error != nil {
                    promise(.failure(.unableToWriteHealthRecord))
                    return
                }
                promise(.success(success))
            }
        }
    }
    
    func readHealthRecord(type: HKSampleType?) -> AnyPublisher<[HKQuantitySample]?, HealthError> {
        let subject = PassthroughSubject<[HKQuantitySample]?, HealthError>()
        if let type = type {
            self.healthQuery = HKSampleQuery(sampleType: type, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil, resultsHandler: { query, samples, error in
                if let error = error {
                    print(error.localizedDescription)
                    subject.send(completion: .failure(.unableToReadHealthRecord))
                }
                guard let samples = samples else { return }
                subject.send(samples as? [HKQuantitySample])
                subject.send(completion: .finished)
            })
        }
        if let healthQuery = healthQuery {
            self.healthStore?.execute(healthQuery)
        }
        return subject.eraseToAnyPublisher()
    }
    
    func removeHealthRecord(object: HKObject?) -> Future<Bool, HealthError> {
        Future { promise in
            guard let object = object else { return }
            self.healthStore?.delete(object) { success, error in
                if error != nil {
                    promise(.failure(.unableToRemoveHealthRecord))
                    return
                }
                promise(.success(success))
            }
        }
    }
}
