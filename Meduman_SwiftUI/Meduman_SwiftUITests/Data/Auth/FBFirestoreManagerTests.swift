//
//  FBFirestoreManagerTests.swift
//  Meduman_SwiftUITests
//
//  Created by Shak Feizi on 12/22/21.
//

import XCTest
@testable import Meduman_SwiftUI

class FBFirestoreManagerTests: XCTestCase {
    // SHAK: Properties
    var sut: FirestoreRepository?
    
    // SHAK: Lifecycle
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = FirestoreRepository()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    // SHAK: Functions
    func testFBFirestoreManager_CanCreateUserProfile() {
        let expectation = expectation(description: "It can create user profile.")
        let user = User(uid: "xiHaHI19ToS57HV1XLaB2VZB0hE2", firstName: "Alex", lastName: "Wilson", email: "alex.wilson@gmail.com", phoneNumber: "8086648866")
        sut?.createUserProfile(user: user, completion: { [weak self] (user, error) in
            expectation.fulfill()
            XCTAssertNotNil(user)
        })
        wait(for: [expectation], timeout: 5)
    }
    
    func testFBFirestoreManager_CanCreate_ReturnError() {
        let expectation = expectation(description: "It can return error.")
        let user = User(uid: "2637673", firstName: "", lastName: "", email: "", phoneNumber: "")
        sut?.createUserProfile(user: user, completion: { [weak self] (user, error) in
            expectation.fulfill()
            XCTAssertNotNil(error)
        })
        wait(for: [expectation], timeout: 5)
    }
    
    func testFBFirestoreManager_CanFetchUserProfile() {
        let expectation = expectation(description: "It can fetch user profile.")
        sut?.fetchUserProfile(userId: "xiHaHI19ToS57HV1XLaB2VZB0hE2", completion: { [weak self] (user, error) in
            print(user?.email)
            expectation.fulfill()
            XCTAssertNotNil(user)
        })
        wait(for: [expectation], timeout: 5)
    }
    
    func testFBFirestoreManager_CanFetch_ReturnError() {
        let expectation = expectation(description: "It can return error.")
        sut?.fetchUserProfile(userId: "2354", completion: { [weak self] (user, error) in
            expectation.fulfill()
            XCTAssertNotNil(error)
        })
        wait(for: [expectation], timeout: 5)
    }
}
