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
    var sut: HealthRepository!
    var mock = HealthStoreMock()
    var cancellables = Set<AnyCancellable>()

    //MARK: - Lifecycles
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = HealthRepository(healthStore: mock)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }

    //MARK: - Functions
    func testRequestAuthorization_CanReturnTrue() {
        let expectation = expectation(description: "Successfully tested requestAuthorization by returning true.")
        sut?.requestAuthorization(completion: { authorized, error in
            if error != nil {
                print(error!)
            }
            guard let authorized = authorized else { return }
            XCTAssertTrue(authorized)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 2)
    }
}

