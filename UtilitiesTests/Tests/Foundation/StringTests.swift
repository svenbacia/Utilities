//
//  StringTests.swift
//  UtilitiesTests
//
//  Created by Sven Bacia on 03.01.18.
//  Copyright © 2018 Sven Bacia. All rights reserved.
//

import XCTest
import Utilities

class StringTests: XCTestCase {

    func testStringAsUrl() {
        let url = "www.test.com".asUrl
        XCTAssertNotNil(url)
        XCTAssertEqual(URL(string: "www.test.com"), url)
    }
}
