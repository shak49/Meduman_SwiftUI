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
    var sut: HealthRepository?
    var healthStoreMock: HKHealthStore? = mock(HKHealthStore.self)
    var healthQueryMock: HKSampleQuery? = mock(HKSampleQuery.self)

    //MARK: - Lifecycle
    override func setUpWithError() throws {
        self.sut = HealthRepository(healthStore: healthStoreMock, healthQuary: healthQueryMock)
    }

    override func tearDownWithError() throws {
        self.sut = nil
    }

    //MARK: - Functions
    func testRequestAuthorization_CanReturnTrue() {
        let expectation = expectation(description: "\"requestAuthorization\" function can return true!")
        sut?.requestAuthorization()
            .sink(receiveCompletion: { _ in
                print("FINISHED!")
            }, receiveValue: { authorized in
                print("AUTHORIZED: \(authorized)!")
                expectation.fulfill()
                XCTAssertTrue(authorized)
            })
        wait(for: [expectation], timeout: 2)
    }
}
