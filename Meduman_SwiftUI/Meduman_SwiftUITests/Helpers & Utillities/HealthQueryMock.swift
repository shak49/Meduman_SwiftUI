//
//  HealthQueryMock.swift
//  Meduman_SwiftUITests
//
//  Created by Shak Feizi on 12/19/22.
//

import HealthKit


class HealthQueryMock: HKSampleQuery {
    //MARK: - Properties
    var sampleQuery: HKSampleQuery?
    var samples: [HKSample]?
    var error: Error?
    
    //MARK: - Lifecycles
    init(sampleType: HKSampleType, predicate: NSPredicate?, limit: Int, sortDescriptors: [NSSortDescriptor]?, resultsHandler: @escaping (HKSampleQuery?, [HKSample]?, Error?) -> Void) {
        let sampleQuery = self.sampleQuery
        let samples = self.samples
        let error = self.error
        resultsHandler(sampleQuery, samples, error)
        super.init(sampleType: sampleType, predicate: predicate, limit: limit, sortDescriptors: sortDescriptors, resultsHandler: resultsHandler)
    }
}
