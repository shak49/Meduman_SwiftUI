//
//  CreateRecordViewUITests.swift
//  Meduman_SwiftUI_UITests
//
//  Created by Shak Feizi on 1/19/23.
//

import XCTest


class CreateRecordViewUITests: XCTestCase {
    //MARK: - Properties
    var app = XCUIApplication()

    //MARK: - Lifecycles
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        self.app.launch()

    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
    }

    //MARK: - Functions
    func test_addHealthRecord() {
        let addButton = self.app.navigationBars["Health Records"].buttons["addButton"]
        let recordViewNavLabel = self.app.navigationBars["Record"].staticTexts["Record"]
        let healthTypeSegment = self.app.segmentedControls["healthTypeSegment"]
        let textField = self.app.textFields["recordTextField"]
        let record = app.keys["188"]
        let datePicker = self.app.datePickers["recordDatePicker"]
        let createButton = self.app.buttons["createButton"]
        let healthRecordsNabLabel = self.app.navigationBars["Health Records"].staticTexts["Health Records"]
        let recordCell = self.app.tableRows["recordsList"]
        addButton.tap()
        healthTypeSegment.tap()
        textField.tap()
        datePicker.tap()
        createButton.tap()
        XCTAssertTrue(recordCell.exists)
    }

}
