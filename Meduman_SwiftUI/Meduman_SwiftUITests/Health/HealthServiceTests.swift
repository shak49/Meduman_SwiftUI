//
//  HealthServiceTests.swift
//  Meduman_SwiftUITests
//
//  Created by Shak Feizi on 12/7/22.
//

import XCTest
import Combine
import HealthKit
@testable import Meduman_SwiftUI


class HealthServiceTests: XCTestCase {
    //MARK: - Properties
    private var service: HealthService!
    private var healthStoreMock: HealthStoreMock!
    private var healthQueryMock: HealthQueryMock!
    private var cancellables = Set<AnyCancellable>()

    //MARK: - Lifecycles
    override func setUpWithError() throws {
        try super.setUpWithError()
        self.healthStoreMock = HealthStoreMock()
        self.service = HealthService(healthStore: self.healthStoreMock, healthQuery: self.healthQueryMock)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        self.service = nil
    }

    //MARK: - Functions
    func test_requestAuthorization_successfullyAuthorizeAccess() {
        let expectation = expectation(description: "\'requestAuthorization\' can successfully authorize access.")
        healthStoreMock.success = true
        service.requestAuthorization()
            .sink { completion in
                print("COMPLETION: \(completion)")
            } receiveValue: { result in
                expectation.fulfill()
                XCTAssertTrue(result)
            }
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 2)
    }
    
    func test_writeHealthRecord_successfullyWriteRecord() {
        let expectation = expectation(description: "\'writeHealthRecord\' can successfully save in health store when object is available.")
        let record = 188.00
        let health = Health(record: record, typeId: .bloodGlucose, unit: "mg/dL", date: Date.now)
        let object = HealthSampleBuilder.shared.quantitySample(health: health)
        self.service.writeHealthRecord(object: object)
            .sink { completion in
                print("COMPLETION: \(completion)")
            } receiveValue: { result in
                expectation.fulfill()
                XCTAssertTrue(result)
            }
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 2)
    }
    
    func test_readHealthRecord_successfullyReadRecords() {
        let expectation = expectation(description: "\'readHealthRecord\' can successfully return objects.")
        guard let type = HKQuantityType.quantityType(forIdentifier: .bloodGlucose) else { return }
        self.service.readHealthRecord(type: type)
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

