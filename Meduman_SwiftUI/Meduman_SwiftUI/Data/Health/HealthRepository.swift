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
    var healthTypes: Set<HKObjectType> { get }
    
    //MARK: - Functions
    func requestAuthorization() -> AnyPublisher<Bool, HealthError>
    func writeCharacteristicTypeSample()
    func readCharacteristicTypeSample()
    func writeQuantityTypeSample()
    func readQuantityTypeSample()
    func writeCategoryTypeSample()
    func readCategoryTypeSample()
}


class HealthRepository: HealthRepoProtocol {
    //MARK: - Properties
    var healthStore: HKHealthStore?
    var healthQuary: HKSampleQuery?
    var healthTypes: Set<HKObjectType> = []
    
    //MARK: - Lifecycles
    init(healthStore: HKHealthStore?, healthQuary: HKSampleQuery?) {
        self.healthStore = healthStore
        self.healthQuary = healthQuary
    }
    
    //MARK: - Functions
    func requestAuthorization() -> AnyPublisher<Bool, HealthError> {
        
    }
}
