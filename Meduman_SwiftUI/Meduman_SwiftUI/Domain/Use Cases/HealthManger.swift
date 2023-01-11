//
//  HealthManger.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 11/22/22.
//

import HealthKit
import Combine


protocol HealthManagerProtocol {
    //MARK: - Properties
    var repo: HealthRepository? { get }
    
    //MARK: - Lifecycles
    init(repo: HealthRepository?)
    
    //MARK: - Functions
    func authorizeAccess()
    func createHealthRecord(record: HKObject?)
    func readHealthRecord(type: HKSampleType?) -> AnyPublisher<[HKSample]?, HKError>
}

class HealthManager: HealthManagerProtocol {
    //MARK: - Properties
    var repo: HealthRepository?
    private var cancellables = Set<AnyCancellable>()
    let allTypes: Set<HKSampleType> = Set([
        HKSampleType.quantityType(forIdentifier: .bloodGlucose)!,
        HKSampleType.quantityType(forIdentifier: .heartRate)!,
    ])
    
    //MARK: - Lifecycles
    required init(repo: HealthRepository?) {
        self.repo = repo
    }
    
    //MARK: - Functions
    func authorizeAccess() {
        self.repo?.requestAuthorization(types: self.allTypes)
            .sink { completion in
                print(completion)
            } receiveValue: { result in
                print("RESULT FOR REQ AUTH: \(result)")
            }
            .store(in: &cancellables)
    }
    
    func createHealthRecord(record: HKObject?) {
        if let record = record {
            self.repo?.writeHealthRecord(object: record)
                .sink(receiveCompletion: { completion in
                    print(completion)
                }, receiveValue: { result in
                    print(result)
                })
                .store(in: &cancellables)
        }
    }
    
    func readHealthRecord(type: HKSampleType?) -> AnyPublisher<[HKSample]?, HKError> {
        let subject = PassthroughSubject<[HKSample]?, HKError>()
        if let type = type {
            self.repo?.readHealthRecord(type: type)
                .sink(receiveCompletion: { error in
                    if error != nil {
                        print(error)
                        subject.send(completion: error)
                    }
                }, receiveValue: { samples in
                    guard let samples = samples else { return }
                    subject.send(samples)
                })
        }
        return subject.eraseToAnyPublisher()
    }

}
