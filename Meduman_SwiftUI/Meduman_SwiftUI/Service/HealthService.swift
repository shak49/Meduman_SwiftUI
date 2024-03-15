//
//  HealthRepository.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 9/28/22.
//

import HealthKit
import Combine


enum HealthError: LocalizedError {
    case typeNotAvailable
    case unableToAccessRecordsForThisDevice
    case unableToAuthorizeAccess
    case unableToWriteHealthRecord
    case unableToReadHealthRecord
    case unableToRemoveHealthRecord
    case serverError(Error)
    
    var errorDescription: String {
        switch self {
        case .typeNotAvailable:
            return "Type is not available."
        case .unableToAccessRecordsForThisDevice:
            return "Unable to access health records for this device."
        case .unableToAuthorizeAccess:
            return "Unable to authorize access."
        case .unableToWriteHealthRecord:
            return "Unable to write health record."
        case .unableToReadHealthRecord:
            return "The \'HealthKit\' responded with no data."
        case .unableToRemoveHealthRecord:
            return "Unable to remove health record."
        case .serverError(let error):
            return "Error: \(error.localizedDescription)"
        }
    }
}

protocol HealthRepoProtocol {
    typealias FutureCompeletion = Future<Bool, HealthError>
    typealias AnyPublisherCompletion = AnyPublisher<[HKQuantitySample]?, HealthError>
    
    //MARK: - Lifecycles
    init(healthStore: HKHealthStore?, healthQuery: HKSampleQuery?)

    //MARK: - Functions
    func requestAuthorization() -> FutureCompeletion
    func writeHealthRecord(object: HKObject?) -> FutureCompeletion
    func readHealthRecord(type: HKSampleType?) -> AnyPublisherCompletion
    func removeHealthRecord(object: HKObject?) -> FutureCompeletion
}

final class HealthService: HealthRepoProtocol {
    //MARK: - Properties
    private var healthStore: HKHealthStore?
    private var healthQuery: HKQuery?
    private let allTypes: Set<HKSampleType> = Set([
        HKSampleType.quantityType(forIdentifier: .bloodGlucose)!,
        HKSampleType.quantityType(forIdentifier: .heartRate)!,
        HKSampleType.quantityType(forIdentifier: .bloodPressureSystolic)!
    ])
    
    //MARK: - Lifecycles
    required init(healthStore: HKHealthStore?, healthQuery: HKSampleQuery? = nil) {
        self.healthStore = healthStore
        self.healthQuery = healthQuery
    }
    
    //MARK: - Functions
    func requestAuthorization() -> FutureCompeletion {
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
    
    func writeHealthRecord(object: HKObject?) -> FutureCompeletion {
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
    
    func readHealthRecord(type: HKSampleType?) -> AnyPublisherCompletion {
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
    
    func removeHealthRecord(object: HKObject?) -> FutureCompeletion {
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
