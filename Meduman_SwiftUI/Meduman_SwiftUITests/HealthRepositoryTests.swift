//
//  HealthRepositoryTests.swift
//  Meduman_SwiftUITests
//
//  Created by Shak Feizi on 11/18/22.
//

import XCTest
import HealthKit
import Combine
@testable import Meduman_SwiftUI

class HealthRepositoryTests: XCTestCase {
    //MARK: - Properties
    var sut: HealthRepository?
    var mock = HealthStoreMock()

    //MARK: - Lifecycles
    override func setUpWithError() throws {
        sut = HealthRepository(healthStore: mock)
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    //MARK: - Functions
    func testRequestAuthorization_CanReturnTrue() {
        let expectation = expectation(description: "Successfully tested \"requestAuthorization\" by returning true.")
        var result: Bool?
        sut?.requestAuthorization()
            .sink(receiveCompletion: { error in
                print("AUTH REQ ERROR: \(error)")
            }, receiveValue: { authorized in
                result = authorized
            })
        XCTAssertTrue(result != nil)
        expectation.fulfill()
        wait(for: [expectation], timeout: 2)
    }
}
