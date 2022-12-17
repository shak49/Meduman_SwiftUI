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
    private var sut: HealthRepository!
    private var objectBuilder: HealthObjectConstructor!
    private var mock: HKHealthStore!
    private var cancellables = Set<AnyCancellable>()

    //MARK: - Lifecycles
    override func setUpWithError() throws {
        try super.setUpWithError()
        self.mock = HealthStoreMock()
        self.objectBuilder = HealthObjectConstructor()
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
    
    func test_writeHealthRecord_canSuccessfullyWrite() {
        let expectation = expectation(description: "\'writeHealthRecord\' can successfully write quantity sample.")
        let record = 188.00
        let object = self.objectBuilder.quantitySample(record: record, typeId: .bloodGlucose, unit: "mg/dL")
        self.sut.writeHealthRecord(object: object)
            .sink { completion in
                print("COMPLETION: \(completion)")
                expectation.fulfill()
            } receiveValue: { success in
                print("SUCCESS: \(success)")
                XCTAssertTrue(success)
            }
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 2)
    }
    
    func test_readHealthRecord_CanSuccessfullyRead() {
        
    }
}
