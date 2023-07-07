//
//  Health.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 9/29/22.
//

import HealthKit


struct Health: Identifiable {
    let id: String = UUID().uuidString
    let record: Double?
    let typeId: HKQuantityTypeIdentifier
    let unit: String
    let date: Date
}
