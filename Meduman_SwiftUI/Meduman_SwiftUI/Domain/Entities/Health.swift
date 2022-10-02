//
//  Health.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 9/29/22.
//

import HealthKit


struct Health {
    let id: String?
    let date: Date?
    let bloodType: HKCharacteristicType?
    let bloodGlucose: HKQuantity?
    let bloodPressure: HKQuantity?
    let heartRate: HKQuantity?
    let sleepStatus: HKCategoryType?
}
