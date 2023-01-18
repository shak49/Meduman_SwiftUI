//
//  HealthRecordViewUITests.swift
//  Meduman_SwiftUI_UITests
//
//  Created by Shak Feizi on 1/17/23.
//

import XCTest


class HealthRecordViewUITests: XCTestCase {
    //MARK: - Properties
    var app: XCUIApplication!
    var addButton: XCUIElement!
    var createAlert: XCUIElement!
    
    //MARK: - Lifecycles
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        self.app = XCUIApplication()
        self.app.launch()

    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
    }

    //MARK: - Functions
    func test_createHealthRecord_successfullyCreateRecord() {
        // Add button
        self.addButton = app.buttons["addButton"]
        XCTAssertTrue(self.addButton.waitForExistence(timeout: 2))
        self.addButton.tap()
    }
}
