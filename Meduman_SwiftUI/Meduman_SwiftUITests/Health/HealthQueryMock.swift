//
//  HealthQueryMock.swift
//  Meduman_SwiftUITests
//
//  Created by Shak Feizi on 10/4/22.
//

import HealthKit
import Combine


protocol HKStatisticsCollectionQueryMockProtocol {
    //MARK: - Properties
    var quantityType: HKQuantityType? { get }
    var quantitySamplePredicate: NSPredicate? { get }
    var options: HKStatisticsOptions? { get }
    var anchorDate: Date? { get }
    var intervalComponents: DateComponents? { get }
    var initialResultHandler: ((HKStatisticsCollectionQuery, HKStatisticsCollection?, Error) -> Void)? { get }
    
    //MARK: - Lifecycle
    init(quantityType: HKQuantityType?, quantitySamplePredicate: NSPredicate?, options: HKStatisticsOptions?, anchorDate: Date?, intervalComponents: DateComponents?)
}

class HealthQueryMock: HKStatisticsCollectionQuery, HKStatisticsCollectionQueryMockProtocol {
    
}
