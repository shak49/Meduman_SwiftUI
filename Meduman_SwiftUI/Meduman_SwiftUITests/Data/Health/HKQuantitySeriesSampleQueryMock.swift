//
//  HKHealthQueryMock.swift
//  Meduman_SwiftUITests
//
//  Created by Shak Feizi on 10/12/22.
//

import HealthKit


class HKQuantitySeriesSampleQueryMock: HKQuantitySeriesSampleQuery {
    //MARK: - Properties
    
    //MARK: - Lifecycles
    override init(quantityType: HKQuantityType, predicate: NSPredicate?, quantityHandler: @escaping(HKQuantitySeriesSampleQuery, HKQuantity?, DateInterval?, HKQuantitySample?, Bool, Error?) -> Void) {
        super.init(quantityType: quantityType, predicate: predicate, quantityHandler: quantityHandler)
    }

    
}
