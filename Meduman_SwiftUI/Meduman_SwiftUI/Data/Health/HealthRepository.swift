//
//  HealthRepository.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 9/28/22.
//

import HealthKit


protocol HealthProtocol {
    //MARK: - Properties
    var healthStore: HKHealthStore? { get }
    var healthTypes: Set<HKObjectType> { get }
    var healthQuary: HKStatisticsCollectionQuery? { get }
    
    //MARK: - Functions
    func requestAuthorization()
    func writeCharacteristicTypeSample()
    func readCharacteristicTypeSample()
    func writeQuantityTypeSample()
    func readQuantityTypeSample()
    func writeCategoryTypeSample()
    func readCategoryTypeSample()
}


class HealthRepository {
    
}
