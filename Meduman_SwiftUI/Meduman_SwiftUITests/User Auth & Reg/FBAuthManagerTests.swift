//
//  FBAuthManagerTests.swift
//  Meduman_SwiftUITests
//
//  Created by Shak Feizi on 12/22/21.
//

import XCTest
@testable import Meduman_SwiftUI

class FBAuthManagerTests: XCTestCase {
    // SHAK: Properties
    var sut: FBAuthManager?
    
    // SHAK: Lifecycle
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = FBAuthManager()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }

    // SHAK: Functions
    func testFBAuthManager_SignUp_CanCreateUser() {
        let expectation = expectation(description: "Sign-Up function can create a user.")
        sut?.signUp(firstName: "Alex", lastName: "Wilson", email: "alex.wilson@gmail.com", password: "alex.1234", phoneNumber: "8086648866", completion: { [weak self] (user, error) in
            if let error = error {
                print("Sign-Up error: \(error)")
            }
            expectation.fulfill()
            XCTAssertNotNil(user as Any)
        })
    }
}
