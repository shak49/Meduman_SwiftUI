//
//  HealthRepositoryTests.swift
//  Meduman_SwiftUITests
//
//  Created by Shak Feizi on 12/7/22.
//

import XCTest
import Combine
import HealthKit
@testable import Meduman_SwiftUI


class HealthRepositoryTests: XCTestCase {
    //MARK: - Properties
    var sut: HealthRepository!
    var mock: HKHealthStore!
    private var cancellables = Set<AnyCancellable>()

    //MARK: - Lifecycles
    override func setUpWithError() throws {
        try super.setUpWithError()
        self.mock = HealthStoreMock()
        self.sut = HealthRepository(healthStore: self.mock)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        self.sut = nil
    }

    //MARK: - Functions
    func test_requestAuthorization_canAuthorizeAccess() {
        let expectation = expectation(description: "\'requestAuthorization\' can successfully authorize access.")
        sut.requestAuthorization()
            .sink { completion in
                print("COMPLETION: \(completion)")
            } receiveValue: { success in
                expectation.fulfill()
                XCTAssertTrue(success)
            }
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 2)
    }
    
    func test_writeQuantityTypeSample_canSuccessfullyWrite() {
        let record = 18.00
        let expectation = expectation(description: "\'writeQuantityTypeSample\' can successfully write quantity sample.")
        sut.writeQuantityTypeSample(record: record)
            .sink { completion in
                print("COMPLETION: \(completion)")
            } receiveValue: { success in
                print("SUCCESS: \(success)")
                expectation.fulfill()
                XCTAssertTrue(success)
            }
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 2)
    }
    
    func test_WriteQuantityTypeSample_CanReturnError() {
        
    }
}
