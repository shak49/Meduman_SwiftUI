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
    var repo: HealthRepository { get }
    
    //MARK: - Lifecycles
    init(repo: HealthRepository)
    
    //MARK: - Functions
    func authorizeAccess()
}

class HealthManager: HealthManagerProtocol {
    //MARK: - Properties
    var repo: HealthRepository
    private var cancellables = Set<AnyCancellable>()
    let allTypes: Set<HKSampleType> = Set([
        HKSampleType.quantityType(forIdentifier: .bloodGlucose)!,
        HKSampleType.quantityType(forIdentifier: .heartRate)!,
    ])
    
    //MARK: - Lifecycles
    required init(repo: HealthRepository) {
        self.repo = repo
    }
    
    //MARK: - Functions
    func authorizeAccess() {
        repo.requestAuthorization(types: self.allTypes)
            .sink { completion in
                print(completion)
            } receiveValue: { result in
                print("RESULT FOR REQ AUTH: \(result)")
            }
            .store(in: &cancellables)
    }

}
