//
//  HKHealthQueryMock.swift
//  Meduman_SwiftUITests
//
//  Created by Shak Feizi on 10/12/22.
//

import HealthKit


class HKSampleQueryMock {
    //MARK: - Properties
    let sampleQuery: HKSampleQuery?
    let sample: [HKSample]?
    let error: Error?
    
    //MARK: - Lifecycles
    init(sampleType: HKSampleType, predicate: NSPredicate?, limit: Int, sortDescriptors: [NSSortDescriptor]?, resultsHandler: @escaping (HKSampleQuery?, [HKSample]?, Error?) -> Void) {
        if sampleType != nil, predicate != nil, limit != nil, sortDescriptors != nil {
            resultsHandler(self.sampleQuery, self.sample, nil)
        } else {
            resultsHandler(nil, nil, self.error)
        }
    }
}
