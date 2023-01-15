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
    func readHealthRecord(type: HKSampleType?) -> AnyPublisher<[Health]?, HKError>
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
    
    func readHealthRecord(type: HKSampleType?) -> AnyPublisher<[Health]?, HKError> {
        let subject = PassthroughSubject<[Health]?, HKError>()
        if let type = type {
            self.repo?.readHealthRecord(type: type)
                .compactMap { subject.send($0?.compactMap(Health.init)) }
                .eraseToAnyPublisher()
        }
        return subject.eraseToAnyPublisher()
    }

}
