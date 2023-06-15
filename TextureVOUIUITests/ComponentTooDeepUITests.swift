//
//  ComponentTooDeepUITests.swift
//  TextureVOUIUITests
//
//  Created by jefferson.setiawan on 15/06/23.
//

import XCTest

class ComponentTooDeepUITests: XCTestCase {
    
    func testTexturePage() {
        UITestPage.app.launch()
        UITestPage.app.tables.cells.element(boundBy: 7).tap()
        UITestPage.app.tables.cells.element(boundBy: 0).tap()
        let c20 = UITestPage.app.otherElements["component-20"]
        XCTAssertTrue(c20.exists)
        let c40 = c20.otherElements["component-40"]
        XCTAssertTrue(c40.exists)
    }
    
    func testUIKitPage() {
        UITestPage.app.launch()
        UITestPage.app.tables.cells.element(boundBy: 7).tap()
        UITestPage.app.tables.cells.element(boundBy: 0).tap()
        let c20 = UITestPage.app.otherElements["component-20"]
        XCTAssertTrue(c20.exists)
        let c40 = c20.otherElements["component-40"]
        XCTAssertTrue(c40.exists)
    }
}
