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
    func createHealthRecord(object: HKObject?)
    func readHealthRecord(type: HKSampleType?) -> AnyPublisher<[HKQuantitySample]?, HealthError>
    func removeHealthRecord(sample: HKQuantitySample)
}

class HealthUseCase: HealthUseCaseProtocol {
    //MARK: - Properties
    var repo: HealthRepository?
    private var cancellables = Set<AnyCancellable>()
    let allTypes: Set<HKSampleType> = Set([
        HKSampleType.quantityType(forIdentifier: .bloodGlucose)!,
        HKSampleType.quantityType(forIdentifier: .heartRate)!,
        HKSampleType.quantityType(forIdentifier: .bloodPressureSystolic)!
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
                    print("> AUTHORIZE COMPLETION:", completion)
                case .failure(let error):
                    print("> ERROR:", error.localizedDescription)
                }
            } receiveValue: { success in
                print("> AUTHORIZED: \(success)")
            }
            .store(in: &cancellables)
    }
    
    func createHealthRecord(object: HKObject?) {
        if let object = object {
            self.repo?.writeHealthRecord(object: object)
                .sink(receiveCompletion: { completion in
                    switch  completion {
                    case .finished:
                        print("> CREATE COMPLETION:", completion)
                    case .failure(let error):
                        print("> ERROR:", error)
                    }
                }, receiveValue: { result in
                    print("> SAVED:", result)
                })
                .store(in: &cancellables)
        }
    }
    
    func readHealthRecord(type: HKSampleType?) -> AnyPublisher<[HKQuantitySample]?, HealthError> {
        let subject = PassthroughSubject<[HKQuantitySample]?, HealthError>()
        if let type = type {
            self.repo?.readHealthRecord(type: type)
                .sink(receiveCompletion: { completion in
                    switch  completion {
                    case .finished:
                        print("> READ COMPLETION:", completion)
                    case .failure(let error):
                        print("> ERROR:", error.localizedDescription)
                    }
                }, receiveValue: { samples in
                    if let samples = samples {
                        print("> SAMPLES:", samples)
                        subject.send(samples)
                    }
                })
                .store(in: &cancellables)
                
        }
        return subject.eraseToAnyPublisher()
    }
    
    func removeHealthRecord(sample: HKQuantitySample) {
        self.repo?.removeHealthRecord(object: sample)
            .sink(receiveCompletion: { completion in
                print("> DELETE COMPLETION:", completion)
            }, receiveValue: { result in
                print("> DELETED:", result)
            })
            .store(in: &cancellables)
    }
}
