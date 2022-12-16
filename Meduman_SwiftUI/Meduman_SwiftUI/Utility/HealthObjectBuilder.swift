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
    func bloodGlucose(record: Double?) -> HKQuantitySample? {
        guard let record = record else { return nil }
        guard let bloodGlucose = HKQuantityType.quantityType(forIdentifier: .bloodGlucose) else {
            fatalError("Step Count Type is no longer available in HealthKit")
        }
        let unit: HKUnit = HKUnit(from: "mg/dL")
        let quantity = HKQuantity(unit: unit, doubleValue: record)
        let sample = HKQuantitySample(type: bloodGlucose, quantity: quantity, start: Date(), end: Date())
        return sample
    }
}
