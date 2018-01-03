//
//  PathTests.swift
//  UtilitiesTests
//
//  Created by Sven Bacia on 03.01.18.
//  Copyright © 2018 Sven Bacia. All rights reserved.
//

import XCTest
import Utilities

class PathTests: XCTestCase {

    func testDocumentsDirectory() {
        XCTAssertNotNil(Path.documentsDirectory)
    }

    func testPrivateDocumentsDirectory() {
        XCTAssertNotNil(Path.privateDocumentsDirectory)
    }

    func testCacheDirectory() {
        XCTAssertNotNil(Path.cacheDirectory)
    }

    func testTemporaryDirectory() {
        XCTAssertNotNil(Path.temporaryDirectory)
    }
}
