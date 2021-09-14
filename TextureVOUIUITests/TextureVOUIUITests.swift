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
    
    // FailureIdentifier1VC UITest
    func testIdentifier1() {
        let app = XCUIApplication()
        app.launch()
        app.tables.cells.element(boundBy: 3).tap()
        
        // expect the element exist
        // NOTE: proofing isAccessibilityElement = true is blocking the children identifier
        
        // textInput Blue Node
        XCTAssertTrue(app.otherElements["blue-box-textInput-identifier"].exists)
        
        // textInput green Node
        XCTAssertTrue(app.otherElements["green-box-textInput-identifier"].exists)
        
        // textInput Blue Node
        XCTAssertTrue(app.otherElements["magenta-box-textInput-identifier"].exists)

        // red box Node
        XCTAssertTrue(app.otherElements["gray-box-identifier"].exists)
        
        // red box Node
        XCTAssertTrue(app.otherElements["yellow-box-identifier"].exists)
        
        // red box Node
        XCTAssertTrue(app.otherElements["red-box-identifier"].exists)
        
        // cyan box Node
        XCTAssertTrue(app.otherElements["cyan-box-identifier"].exists)
            
        // brown box Node
        XCTAssertTrue(app.otherElements["brown-nested-box-identifier"].exists)
    }
}
