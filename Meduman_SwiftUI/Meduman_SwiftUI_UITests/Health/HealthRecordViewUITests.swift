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

}
