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
    private var healthStoreMock: HealthStoreMock!
    private var healthQueryMock: HealthQueryMock!
    private var cancellables = Set<AnyCancellable>()

    //MARK: - Lifecycles
    override func setUpWithError() throws {
        try super.setUpWithError()
        self.healthStoreMock = HealthStoreMock()
        self.objectBuilder = HealthObjectConstructor()
        self.sut = HealthRepository(healthStore: self.healthStoreMock, healthQuery: self.healthQueryMock)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        self.sut = nil
    }

    //MARK: - Functions
    func test_requestAuthorization_canReturnTrue() {
        let allTypes: Set<HKSampleType> = Set([
            HKSampleType.quantityType(forIdentifier: .bloodGlucose)!,
            HKSampleType.quantityType(forIdentifier: .heartRate)!,
        ])
        let expectation = expectation(description: "\'requestAuthorization\' can successfully return true.")
        sut.requestAuthorization(types: allTypes)
            .sink { completion in
                print("COMPLETION: \(completion)")
            } receiveValue: { result in
                expectation.fulfill()
                XCTAssertTrue(result)
            }
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 2)
    }
    
    func test_writeHealthRecord_canReturnTrue() {
        let expectation = expectation(description: "\'writeHealthRecord\' can successfully return true.")
        let record = 188.00
        let object = self.objectBuilder.quantitySample(record: record, typeId: .bloodGlucose, unit: "mg/dL")
        self.sut.writeHealthRecord(object: object)
            .sink { completion in
                print("COMPLETION: \(completion)")
            } receiveValue: { result in
                expectation.fulfill()
                XCTAssertTrue(result)
            }
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 2)
    }
    
    func test_readHealthRecord_canReturnObjects() {
        let expectation = expectation(description: "\'readHealthRecord\' can successfully return true.")
        guard let type = HKQuantityType.quantityType(forIdentifier: .bloodGlucose) else { return }
        sut.readHealthRecord(type: type)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print("COMPLETION:", completion)
            } receiveValue: { results in
                expectation.fulfill()
                XCTAssertNotNil(results)
            }
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 2)
    }
}
