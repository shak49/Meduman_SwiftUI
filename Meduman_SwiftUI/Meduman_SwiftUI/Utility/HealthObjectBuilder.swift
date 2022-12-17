//
//  ObjectBuilder.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 12/15/22.
//

import HealthKit


class HealthObjectBuilder {
    //MARK: - Properties
    
    //MARK: - Functions
    func quantityType(record: Double?, typeId: HKQuantityTypeIdentifier, unit: String) -> HKQuantitySample? {
        guard let record = record else { return nil }
        guard let type = HKQuantityType.quantityType(forIdentifier: typeId) else {
            fatalError("This quantity type is no longer available.")
        }
        let unit: HKUnit = HKUnit(from: unit)
        let quantity = HKQuantity(unit: unit, doubleValue: record)
        let sample = HKQuantitySample(type: type, quantity: quantity, start: Date(), end: Date())
        return sample
    }
}
