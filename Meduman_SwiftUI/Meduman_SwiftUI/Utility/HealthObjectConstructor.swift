//
//  ObjectBuilder.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 12/15/22.
//

import HealthKit


class HealthObjectConstructor {
    //MARK: - Properties
    var query: HKSampleQuery?
    
    //MARK: - Functions
    func quantitySample(record: Double?, typeId: HKQuantityTypeIdentifier, unit: String) -> HKQuantitySample? {
        guard let record = record else { return nil }
        let type = sampleType(typeId: typeId)
        let unit: HKUnit = HKUnit(from: unit)
        let quantity = HKQuantity(unit: unit, doubleValue: record)
        let sample = HKQuantitySample(type: type, quantity: quantity, start: Date(), end: Date())
        return sample
    }
    
    func quarySample() -> HKSampleQuery {
        
    }
    
    private func sampleType(typeId: HKQuantityTypeIdentifier) -> HKQuantityType {
        guard let type = HKQuantityType.quantityType(forIdentifier: typeId) else {
            fatalError("This quantity type is no longer available.")
        }
        return type
    }
}
