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
    private var objectBuilder: HealthObjectBuilder!
    private var mock: HKHealthStore!
    private var cancellables = Set<AnyCancellable>()

    //MARK: - Lifecycles
    override func setUpWithError() throws {
        try super.setUpWithError()
        self.mock = HealthStoreMock()
        self.objectBuilder = HealthObjectBuilder()
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
        let expectation = expectation(description: "\'writeQuantityTypeSample\' can successfully write quantity sample.")
        let record = 188.00
        let object = self.objectBuilder.bloodGlucose(record: record)
        self.sut.writeQuantityTypeSample(object: object)
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
    
    func test_WriteQuantityTypeSample_CanReturnError() {
//        let expectation = expectation(description: "\'writeQuantityTypeSample\' can successfully throuwn error.")
//        let record = 188.00
//        guard let bloodGlucose = HKQuantityType.quantityType(forIdentifier: .bloodGlucose) else {
//            fatalError("Step Count Type is no longer available in HealthKit")
//        }
//        let unit: HKUnit = HKUnit(from: "mg/dL")
//        let quantity = HKQuantity(unit: unit, doubleValue: record)
//        let sample = HKQuantitySample(type: bloodGlucose, quantity: quantity, start: Date(), end: Date())
//        self.sut.writeQuantityTypeSample(object: sample)
//            .sink { completion in
//                print("COMPLETION: \(completion)")
//                expectation.fulfill()
//            } receiveValue: { error in
//                print("---\(error)---")
//                XCTAssertNotNil(error)
//            }
//            .store(in: &cancellables)
//        wait(for: [expectation], timeout: 2)
    }
}
