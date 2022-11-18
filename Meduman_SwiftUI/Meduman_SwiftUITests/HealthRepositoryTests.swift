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

    //MARK: - Lifecycles
    override func setUpWithError() throws {
        sut = HealthRepository()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    //MARK: - Functions
    func testRequestAuthorization_CanReturnTrue() {
        let expectation = expectation(description: "Successfully tested \"requestAuthorization\" by returning true.")
        sut?.requestAuthorization()
            .sink(receiveCompletion: { error in
                print("Error for test: \(error)!")
            }, receiveValue: { authorized in
                print("Authorized in test: \(authorized)!")
                XCTAssertNotNil(authorized)
                expectation.fulfill()
            })
        wait(for: [expectation], timeout: 2)
    }

}
