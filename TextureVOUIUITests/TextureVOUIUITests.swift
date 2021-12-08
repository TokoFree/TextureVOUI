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
        // XCTAssertTrue(app.staticTexts["Demo for IsAccessibilityElement = true case"].exists)
        
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
        XCTAssertEqual(app.staticTexts.element(matching: .any, identifier: "textAssert2").label, "test") // expectednya textLabelNih
        XCTAssertEqual(app.staticTexts.element(matching: .any, identifier: "textAssert2").value as! String, "test")
        XCTAssertEqual(app.staticTexts.element(matching: .any, identifier: "textAssert2").title, "test")
        
        XCTAssertEqual(app.buttons["controlNode"].label, "test")
        XCTAssertEqual(app.buttons["controlNode"].value as! String, "test")
        XCTAssertEqual(app.buttons["controlNode"].title, "test")
        
        // red box Node
        XCTAssertTrue(app.otherElements["yellow-box-identifier"].exists)
        
        // red box Node
        XCTAssertTrue(app.otherElements["red-box-identifier"].exists)
        XCTAssertEqual(app.staticTexts.element(matching: .any, identifier: "textAssert").label, "test")
        
        // cyan box Node
        XCTAssertTrue(app.otherElements["cyan-box-identifier"].exists)
            
        // brown box Node
        XCTAssertTrue(app.otherElements["brown-nested-box-identifier"].exists)
    }
    
    // FailureIdentifier1VC UITest
    func testIdentifier2() {
        
        let app = XCUIApplication()
        app.launch()
        app.tables.cells.element(boundBy: 5).tap()
        
        XCTAssertEqual(app.buttons["button"].isSelected, true)
        XCTAssertEqual(app.buttons["button"].label, "test")
        XCTAssertEqual(app.buttons["button"].value as! String, "test")
        XCTAssertEqual(app.buttons["button"].title, "test")
        
        XCTAssertEqual(app.textFields["textfield"].label, "test")
        XCTAssertEqual(app.textFields["textfield"].value as! String, "test")
        XCTAssertEqual(app.textFields["textfield"].title, "test")
    }
    
    func test_sharing_identifier() {
        
        let app = XCUIApplication()
        app.launch()
        app.tables.cells.element(boundBy: 6).tap()
        
        XCTAssertTrue(app.staticTexts["titleText"].exists)
        XCTAssertTrue(app.buttons["buttonNode"].exists)
        XCTAssertTrue(app.staticTexts["NewTextLabel"].exists)
    }
}
