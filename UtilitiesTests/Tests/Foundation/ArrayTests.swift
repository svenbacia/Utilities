//
//  ArrayTests.swift
//  UtilitiesTests
//
//  Created by Sven Bacia on 03.01.18.
//  Copyright © 2018 Sven Bacia. All rights reserved.
//

import XCTest
import Utilities

class ArrayTests: XCTestCase {

    public func testUnique() {
        let array = [5, 1, 1, 2, 3, 4, 4, 5, 5]
        XCTAssertEqual(array.uniqueElements, [5, 1, 2, 3, 4])
    }
}
