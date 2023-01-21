//
//  CreateRecordViewUITests.swift
//  Meduman_SwiftUI_UITests
//
//  Created by Shak Feizi on 1/19/23.
//

import XCTest

class CreateRecordViewUITests: XCTestCase {
    //MARK: - Properties
    var app: XCUIApplication!

    //MARK: - Lifecycles
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        self.app = XCUIApplication()

    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        //self.app = nil
    }

    //MARK: - Functions
    func test_createHealthRecord_successfullyCreateRecord() {
        
    }
}
