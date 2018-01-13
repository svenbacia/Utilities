//
//  BoolTests.swift
//  UtilitiesTests
//
//  Created by Sven Bacia on 03.01.18.
//  Copyright © 2018 Sven Bacia. All rights reserved.
//

import XCTest
import Utilities

class BoolTests: XCTestCase {

    func testFlip() {
        var yes = true
        XCTAssertTrue(yes)

        yes.toggle()
        XCTAssertFalse(yes)
    }

    func testFlipped() {
        XCTAssertTrue(false.toggled())
        XCTAssertFalse(true.toggled())
    }
}
