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
        let addButton = self.app.navigationBars["Health Records"]
        addButton.tap()
        let recordViewNavLabel = self.app.navigationBars["Record"].staticTexts["Record"]
        let mealTimeSegment = self.app.segmentedControls["recordSegment"].buttons["Before Meal"]
        mealTimeSegment.tap()
        let textField = self.app.textFields["recordTextField"]
        textField.tap()
        let bloodGlucoseRecord = app.keys["188"]
        bloodGlucoseRecord.tap()
        let datePicker = self.app.datePickers["recordDatePicker"]
        datePicker.tap()
        let createButton = self.app.navigationBars["Record"].buttons["createButton"]
        createButton.tap()
        let healthRecordsNabLabel = self.app.navigationBars["Health Records"].staticTexts["Health Records"]
        // Here we need to check wheather cell has created or not after doing all the actions
        // 1) let cell =
        // 2) XCTAssertTrue(cell.exists)
    }

}
