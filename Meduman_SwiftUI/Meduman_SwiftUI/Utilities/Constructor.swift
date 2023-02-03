//
//  ObjectBuilder.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 12/15/22.
//

import HealthKit


class Constructor {
    //MARK: - Properties
    static let shared = Constructor()
    
    //MARK: - Functions
    func quantitySample(health: Health?) -> HKQuantitySample? {
        guard let health = health else { return nil }
        guard let type = HKQuantityType.quantityType(forIdentifier: health.typeId) else {
            fatalError("This quantity type is no longer available.")
        }
        let unit: HKUnit = HKUnit(from: health.unit)
        let quantity = HKQuantity(unit: unit, doubleValue: health.record ?? 0.0)
        let sample = HKQuantitySample(type: type, quantity: quantity, start: health.date, end: health.date)
        return sample
    }
}
