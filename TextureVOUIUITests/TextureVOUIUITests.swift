//
//  TextureVOUIUITests.swift
//  TextureVOUIUITests
//
//  Created by Jefferson Setiawan on 13/09/21.
//

import XCTest

class TextureVOUIUITests: XCTestCase {
    func testIsAccessibilityElementTrue() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        app.tables.cells.element(boundBy: 0).tap()
        
        // This is not a good way to check the view/node (using text)
//        XCTAssertTrue(app.staticTexts["Demo for IsAccessibilityElement = true case"].exists)
        
        // Instead you can assign `.accessibilityIdentifier`
        XCTAssertTrue(app.staticTexts["explanationTextNode"].exists)
    }
}
