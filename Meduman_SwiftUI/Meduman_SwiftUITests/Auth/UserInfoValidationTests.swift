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
        XCTAssertTrue(sut!.validateFirstName())
    }
    
    func testUserModelObject_IsNotValidFirstName() {
        sut = User(firstName: "SS")
        XCTAssertFalse(sut!.validateFirstName())
    }
    
    func testUserModelObject_IsValidLastName() {
        sut = User(lastName: Person.lastName.rawValue)
        XCTAssertTrue(sut!.validateLastName())
    }
    
    func testUserModelObject_IsNotValidLastName() {
        sut = User(lastName: "FF")
        XCTAssertFalse(sut!.validateLastName())
    }
    
    func testUserModelObject_IsValidEmail() {
        sut = User(email: Person.email.rawValue)
        XCTAssertTrue(sut!.validateEmail())
    }
    
    func testUserModelObject_IsNotValidEmail() {
        sut = User(email: "shakfeizigmailcom")
        XCTAssertFalse(sut!.validateEmail())
    }
    
    func testUserModelObject_IsValidPhoneNumber() {
        sut = User(phoneNumber: Person.phoneNumber.rawValue)
        XCTAssertTrue(sut!.validatePhoneNumber())
    }
    
    func testUserModelObject_IsNotValidPhoneNumber() {
        sut = User(phoneNumber: "801888888")
        XCTAssertFalse(sut!.validatePhoneNumber())
    }
}
