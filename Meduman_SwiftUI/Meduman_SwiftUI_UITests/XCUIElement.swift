//
//  XCUIElement.swift
//  Meduman_SwiftUI_UITests
//
//  Created by Shak Feizi on 7/4/23.
//

import XCTest


extension XCUIElement {
     func forceTapElement() {
         if self.isHittable {
             self.tap()
         }
         else {
             let coordinate: XCUICoordinate = self.coordinate(withNormalizedOffset: CGVector(dx: 0.0, dy: 0.0))
             coordinate.tap()
         }
     }
 }
