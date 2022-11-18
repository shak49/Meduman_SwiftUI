//
//  HKHealthQueryMock.swift
//  Meduman_SwiftUITests
//
//  Created by Shak Feizi on 10/12/22.
//

import HealthKit


class HKSampleQueryMock: HKSampleQuery {
    //MARK: - Properties
    let sampleQuery: HKSampleQuery?
    let sample: [HKSample]?
    let error: Error?
    
    //MARK: - Lifecycles
    override init(sampleType: HKSampleType, predicate: NSPredicate?, limit: Int, sortDescriptors: [NSSortDescriptor]?, resultsHandler: @escaping (HKSampleQuery, [HKSample]?, Error?) -> Void) {
        let query = self.sampleQuery
        let sample = self.sample
        let error = self.error
        super.init(sampleType: sampleType, predicate: predicate, limit: limit, sortDescriptors: sortDescriptors) { sampleQuery, samples, error in
            resultsHandler(query, sample, error)
        }
    }
}
