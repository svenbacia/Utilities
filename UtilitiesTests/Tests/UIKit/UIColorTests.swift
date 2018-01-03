//
//  UIColorTests.swift
//  UtilitiesTests
//
//  Created by Sven Bacia on 04.01.18.
//  Copyright © 2018 Sven Bacia. All rights reserved.
//

import XCTest
import Utilities

class UIColorTests: XCTestCase {

    func testColorFromHex() {
        XCTAssertEqual(UIColor(hex: 0x000000), UIColor(red: 0, green: 0, blue: 0, alpha: 1))
    }
}
