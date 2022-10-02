//
//  HealthRepoTests.swift
//  Meduman_SwiftUITests
//
//  Created by Shak Feizi on 10/1/22.
//

import XCTest
import Combine
@testable import Meduman_SwiftUI

class HealthRepoTests: XCTestCase {
    //MARK: - Properties
    var healthRepo: HealthRepository?

    //MARK: - Lifecycle
    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        self.healthRepo = nil
    }

    //MARK: - Functions
    func testRequestAuthorizationReturnTrue() -> AnyPublisher<Bool, HealthError> {
        
    }
}
