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
    var healthQuary: HKSampleQuery? { get }
//    var healthTypes: Set<HKObjectType> { get }
    
    //MARK: - Lifecycles
    init(healthStore: HKHealthStore?, healthQuery: HKSampleQuery?)
    
    //MARK: - Functions
    func requestAuthorization() -> Future<Bool, HKError>
    func writeHealthRecord(object: HKObject?) -> Future<Bool, HKError>
    func readHealthRecord(type: HKSampleType?, predicate: NSPredicate?, limit: Int, sort: [NSSortDescriptor]?) -> AnyPublisher<[Health], HKError>
//    func writeCharacteristicTypeSample()
//    func readCharacteristicTypeSample()
//    func writeCategoryTypeSample()
//    func readCategoryTypeSample()
}


class HealthRepository: HealthRepoProtocol {
    //MARK: - Properties
    var healthStore: HKHealthStore?
    var healthQuary: HKSampleQuery?
    let allTypes: Set<HKSampleType> = Set([
        HKSampleType.quantityType(forIdentifier: .bloodGlucose)!,
        HKSampleType.quantityType(forIdentifier: .heartRate)!,
    ])
    
    //MARK: - Lifecycles
    required init(healthStore: HKHealthStore?, healthQuery: HKSampleQuery?) {
        self.healthStore = healthStore
        self.healthQuary = healthQuery
    }
    
    //MARK: - Functions
    func requestAuthorization() -> Future<Bool, HKError> {
        Future { [weak self] promise in
            self?.healthStore?.requestAuthorization(toShare: self?.allTypes, read: self?.allTypes, completion: { success, error in
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
            if let object = object {
                self.healthStore?.save(object) { success, error in
                    if let error = error {
                        print(error.localizedDescription)
                        promise(.failure(.unableToWriteHealthRecord))
                        return
                    }
                    promise(.success(success))
                }
            }
        }
    }
    
    func readHealthRecord(type: HKSampleType?, predicate: NSPredicate?, limit: Int, sort: [NSSortDescriptor]?) -> AnyPublisher<[Health], HKError> {
        let subject = PassthroughSubject<[Health], HKError>()
        if let type = type {
            self.healthQuary = HKSampleQuery(sampleType: type, predicate: predicate, limit: limit, sortDescriptors: sort, resultsHandler: { query, samples, error in
                if let error = error {
                    print(error.localizedDescription)
                    subject.send(completion: .failure(.unableToReadHealthRecord))
                }
                guard let samples = samples as? [Health] else { return }
                subject.send(samples)
            })
            //self.healthStore?.execute(healthQuary)
        }
        return subject.eraseToAnyPublisher()
    }
}
