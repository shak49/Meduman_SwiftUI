//
//  HealthQueryMock.swift
//  Meduman_SwiftUITests
//
//  Created by Shak Feizi on 12/19/22.
//

import HealthKit


class HealthQueryMock: HKSampleQuery {
    //MARK: - Properties
    let sampleQuery: HKSampleQuery?
    let samples: [HKSample]?
    let error: Error?
    
    //MARK: - Lifecycles
    override init(sampleType: HKSampleType, predicate: NSPredicate?, limit: Int, sortDescriptors: [NSSortDescriptor]?, resultsHandler: @escaping (HKSampleQuery, [HKSample]?, Error?) -> Void) {
        let sampleQuery = self.sampleQuery
        let samples = self.samples
        let error = self.error
        resultsHandler(sampleQuery, samples, error)
    }
}
