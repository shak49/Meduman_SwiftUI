//
//  Meduman_SwiftUITests.swift
//  Meduman_SwiftUITests
//
//  Created by Shak Feizi on 12/21/21.
//

import XCTest
@testable import Meduman_SwiftUI

class UserInfoValidationTests: XCTestCase {
    // SHAK: Properties
    var sut: User?
    
    // SHAK: Lifecycle
    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    // SHAK: Functions
    func testUserModelObject_CanCreateNewInstance() {
        sut = User(firstName: Person.firstName.rawValue, lastName: Person.lastName.rawValue, email: Person.email.rawValue, phoneNumber: Person.phoneNumber.rawValue)
        XCTAssertNotNil(sut)
    }
    
    func testUserModelObject_IsValidFirstName() {
        sut = User(firstName: Person.firstName.rawValue)
        XCTAssertTrue(sut!.isValidFirstName())
    }
    
    func testUserModelObject_IsValidLastName() {
        sut = User(lastName: Person.lastName.rawValue)
        XCTAssertTrue(sut!.isValidLastName())
    }
}
