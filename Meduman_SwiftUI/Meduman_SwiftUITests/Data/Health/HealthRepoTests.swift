//
//  HealthRepoTests.swift
//  Meduman_SwiftUITests
//
//  Created by Shak Feizi on 10/1/22.
//

import XCTest
import Mockingbird
import HealthKit
@testable import Meduman_SwiftUI

class HealthRepoTests: XCTestCase {
    //MARK: - Properties
    var healthRepo: HealthRepository?
    var healthStoreMock: HKHealthStore? = mock(HKHealthStore.self)
    var healthQueryMock: HKSampleQuery? = mock(HKSampleQuery.self)

    //MARK: - Lifecycle
    override func setUpWithError() throws {
        self.healthRepo = HealthRepository(healthStore: healthStoreMock, healthQuary: healthQueryMock)
    }

    override func tearDownWithError() throws {
        self.healthRepo = nil
    }

    //MARK: - Functions
    func testRequestAuthorizationReturnTrue() {
        let expectation = expectation(description: "requestAuthorization function can authorize access!")
        healthRepo?.requestAuthorization()
            .sink(receiveCompletion: { _ in
                print("FINISHED!")
            }, receiveValue: { authorized in
                expectation.fulfill()
                XCTAssertTrue(authorized)
            })
        wait(for: [expectation], timeout: 1)
    }
}
