//
//  IndexPathTests.swift
//  UtilitiesTests
//
//  Created by Sven Bacia on 03.01.18.
//  Copyright © 2018 Sven Bacia. All rights reserved.
//

import XCTest
import Utilities

class IndexPathTests: XCTestCase {
    public func testIndexPathZero() {
        XCTAssertEqual(IndexPath.zero.item, 0)
        XCTAssertEqual(IndexPath.zero.row, 0)
        XCTAssertEqual(IndexPath.zero.section, 0)
    }
}
