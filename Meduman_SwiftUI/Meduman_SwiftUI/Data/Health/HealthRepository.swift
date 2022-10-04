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
    var healthTypes: Set<HKObjectType> { get }
    var healthQuary: HKStatisticsCollectionQuery? { get }
    
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
    var healthStore: HKHealthStore?
}
