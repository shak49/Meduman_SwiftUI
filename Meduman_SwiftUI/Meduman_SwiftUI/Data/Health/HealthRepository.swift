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
    init(healthStore: HKHealthStore?, healthQuery: HKSampleQuery?)
    
    //MARK: - Functions
    func requestAuthorization(types: Set<HKSampleType>?) -> Future<Bool, HKError>
    func writeHealthRecord(object: HKObject?) -> Future<Bool, HKError>
    func readHealthRecord(type: HKSampleType?) -> AnyPublisher<[HKObject]?, HKError>
}


class HealthRepository: HealthRepoProtocol {
    //MARK: - Properties
    var healthStore: HKHealthStore?
    var healthQuery: HKSampleQuery?
    
    //MARK: - Lifecycles
    required init(healthStore: HKHealthStore?, healthQuery: HKSampleQuery?) {
        self.healthStore = healthStore
        self.healthQuery = healthQuery
    }
    
    //MARK: - Functions
    func requestAuthorization(types: Set<HKSampleType>?) -> Future<Bool, HKError> {
        Future { [weak self] promise in
            self?.healthStore?.requestAuthorization(toShare: types, read: types, completion: { success, error in
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
    
    func writeHealthRecord(object: HKObject?) -> Future<Bool, HKError> {
        Future { promise in
            guard let object = object else { return }
            self.healthStore?.save(object) { success, error in
                if let error = error {
                    print("ERROR: \(error.localizedDescription)")
                    promise(.failure(.unableToWriteHealthRecord))
                    return
                }
                promise(.success(success))
            }
        }
    }
    
    func readHealthRecord(type: HKSampleType?) -> AnyPublisher<[HKObject]?, HKError> {
        let subject = PassthroughSubject<[HKObject]?, HKError>()
        if let type = type {
            self.healthQuery = HKSampleQuery(sampleType: type, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil, resultsHandler: { query, samples, error in
                if let error = error {
                    print(error.localizedDescription)
                    subject.send(completion: .failure(.unableToReadHealthRecord))
                }
                guard let samples = samples else { return }
                print("SAMPLES:", samples)
                subject.send(samples)
                subject.send(completion: .finished)
            })
        }
        if let healthQuery = healthQuery {
            self.healthStore?.execute(healthQuery)
        }
        return subject.eraseToAnyPublisher()
    }
}
