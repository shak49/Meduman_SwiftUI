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
    private var sut: HealthService!
    private var healthStoreMock: HealthStoreMock!
    private var healthQueryMock: HealthQueryMock!
    private var cancellables = Set<AnyCancellable>()

    //MARK: - Lifecycles
    override func setUpWithError() throws {
        try super.setUpWithError()
        self.healthStoreMock = HealthStoreMock()
        self.sut = HealthService(healthStore: self.healthStoreMock, healthQuery: self.healthQueryMock)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        self.sut = nil
    }

    //MARK: - Functions
    func test_requestAuthorization_successfullyAuthorizeAccess() {
        let expectation = expectation(description: "\'requestAuthorization\' can successfully authorize access.")
        sut.requestAuthorization()
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
    
    func test_readHealthRecord_successfullyReadRecords() {
        let expectation = expectation(description: "\'readHealthRecord\' can successfully return objects.")
        guard let type = HKQuantityType.quantityType(forIdentifier: .bloodGlucose) else { return }
        self.sut.readHealthRecord(type: type)
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
