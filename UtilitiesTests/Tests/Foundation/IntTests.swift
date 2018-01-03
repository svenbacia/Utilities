//
//  IntTests.swift
//  UtilitiesTests
//
//  Created by Sven Bacia on 03.01.18.
//  Copyright © 2018 Sven Bacia. All rights reserved.
//

import XCTest
import Utilities

class IntTests: XCTestCase {

    func testRandomNumber() {
        XCTAssertLessThanOrEqual(Int.randomNumber(between: 0, and: 1), 1)
        XCTAssertLessThanOrEqual(Int.randomNumber(between: 5, and: 0), 5)
    }
}
