//
//  HealthRepoTests.swift
//  Meduman_SwiftUITests
//
//  Created by Shak Feizi on 10/1/22.
//

import XCTest
@testable import Meduman_SwiftUI

class HealthRepoTests: XCTestCase {
    //MARK: - Properties
    var healthRepo: HealthRepository?
    var mockHealthStore: HealthStoreMock?

    //MARK: - Lifecycle
    override func setUpWithError() throws {
        self.healthRepo = healthRepo(healtStore: mockHealthStore)
    }

    override func tearDownWithError() throws {
        self.healthRepo = nil
    }

    //MARK: - Functions
    func testRequestAuthorizationReturnTrue() {
        
    }
}
