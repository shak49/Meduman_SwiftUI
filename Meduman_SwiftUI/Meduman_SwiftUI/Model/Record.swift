//
//  Record.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 4/14/24.
//

import Foundation
import HealthKit

struct Record: Hashable, Identifiable {
    var quantitySample: HKQuantitySample
    var id: String = UUID().uuidString
    var quantity: Double {
        var newString = ""
        for char in "\(quantitySample.quantity)" {
            if char.isNumber {
                newString += String(char)
            }
        }
        return Double(newString) ?? 0
    }
    var type: String {
        switch quantitySample.quantityType {
        case HKQuantityType(.bloodGlucose):
            return "Glucose"
        case HKQuantityType(.bloodPressureSystolic):
            return "Pressure"
        case HKQuantityType(.heartRate):
            return "Heart"
        default:
            break
        }
        return ""
    }
    var sample: HKSampleType? {
        return quantitySample.sampleType
    }
    var date: String {
        let formattedDate = String(describing: quantitySample.endDate.formatted(Date.FormatStyle().weekday()))
        return formattedDate
    }
}
