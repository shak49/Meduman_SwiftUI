//
//  HealthManger.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 11/22/22.
//

import HealthKit
import Combine


protocol HealthUseCaseProtocol {
    //MARK: - Properties
    var repo: HealthRepository? { get }
    
    //MARK: - Lifecycles
    init(repo: HealthRepository?)
    
    //MARK: - Functions
    func authorizeAccess()
    func createHealthRecord(record: HKObject?)
    func readHealthRecord(type: HKSampleType?) -> AnyPublisher<[HKSample]?, HKError>
}

class HealthUseCase: HealthUseCaseProtocol {
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
                switch  completion {
                case .finished:
                    print("AUTHORIZE COMPLETION:", completion)
                case .failure(let error):
                    print("ERROR:", error.localizedDescription)
                }
            } receiveValue: { success in
                print("SUCCESS: \(success)")
            }
            .store(in: &cancellables)
    }
    
    func createHealthRecord(record: HKObject?) {
        if let record = record {
            self.repo?.writeHealthRecord(object: record)
                .sink(receiveCompletion: { completion in
                    switch  completion {
                    case .finished:
                        print("CREATE COMPLETION:", completion)
                    case .failure(let error):
                        print("ERROR:", error.localizedDescription)
                    }
                }, receiveValue: { result in
                    print("SAVED:", result)
                })
                .store(in: &cancellables)
        }
    }
    
    func readHealthRecord(type: HKSampleType?) -> AnyPublisher<[HKSample]?, HKError> {
        let subject = PassthroughSubject<[HKSample]?, HKError>()
        if let type = type {
            self.repo?.readHealthRecord(type: type)
                .sink(receiveCompletion: { completion in
                    switch  completion {
                    case .finished:
                        print("READ COMPLETION:", completion)
                    case .failure(let error):
                        print("ERROR:", error.localizedDescription)
                    }
                }, receiveValue: { samples in
                    if let samples = samples {
                        print("SAMPLES:", samples)
                        subject.send(samples)
                    }
                })
                .store(in: &cancellables)
                
        }
        return subject.eraseToAnyPublisher()
    }

}
