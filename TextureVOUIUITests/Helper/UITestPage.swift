//
//  Page.swift
//  TextureVOUIUITests
//
//  Created by andhika.setiadi on 13/12/21.
//

import XCTest

internal class UITestPage {
    internal static let app: XCUIApplication = {
        let app = XCUIApplication()
        app.launchArguments.append("UITEST")
        return app
    }()
}
