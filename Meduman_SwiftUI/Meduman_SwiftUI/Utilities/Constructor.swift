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
    func quantitySample(record: Double? = 0.0, typeId: HKQuantityTypeIdentifier?, unit: String, date: Date) -> HKQuantitySample? {
        guard let record = record, let typeId = typeId else { return nil }
        guard let type = HKQuantityType.quantityType(forIdentifier: typeId) else {
            fatalError("This quantity type is no longer available.")
        }
        let unit: HKUnit = HKUnit(from: unit)
        let quantity = HKQuantity(unit: unit, doubleValue: record)
        let sample = HKQuantitySample(type: type, quantity: quantity, start: date, end: date)
        return sample
    }
}
