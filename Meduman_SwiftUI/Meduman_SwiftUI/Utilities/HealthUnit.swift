//
//  Units.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 2/7/23.
//

import Foundation
import HealthKit


enum HealthUnit: String {
    case bloodGlucose
    case bloodPressure
    case heartRate
    
    var localizedString: String {
        switch self {
        case .bloodGlucose:
            return Constraint.shared.localizedString(key: "Health_Blood_Glucose")
        case .bloodPressure:
            return Constraint.shared.localizedString(key: "Health_Blood_Pressure")
        case .heartRate:
            return Constraint.shared.localizedString(key: "Health_Heart_Rate")
        }
    }
}
