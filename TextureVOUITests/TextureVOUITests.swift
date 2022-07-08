//
//  TextureVOUITests.swift
//  TextureVOUITests
//
//  Created by Jefferson Setiawan on 13/09/21.
//

import KIF
@testable import TextureVOUI

class TextureVOUITests: KIFTestCase {

    func testExample() throws {
        let tester = tester()
        tester.tapRow(at: IndexPath(row: 3, section: 0), inTableViewWithAccessibilityIdentifier: "tableView")
    }
}

extension XCTestCase {
    func tester(file : String = #file, _ line : Int = #line) -> KIFUITestActor {
        KIFUITestActor(inFile: file, atLine: line, delegate: self)
    }

    func system(file : String = #file, _ line : Int = #line) -> KIFSystemTestActor {
        KIFSystemTestActor(inFile: file, atLine: line, delegate: self)
    }
}

extension KIFTestActor {
    func tester(file : String = #file, _ line : Int = #line) -> KIFUITestActor {
        KIFUITestActor(inFile: file, atLine: line, delegate: self)
    }

    func system(file : String = #file, _ line : Int = #line) -> KIFSystemTestActor {
        KIFSystemTestActor(inFile: file, atLine: line, delegate: self)
    }
}
