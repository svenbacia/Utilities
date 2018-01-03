//
//  NSLayoutConstraintTests.swift
//  UtilitiesTests
//
//  Created by Sven Bacia on 03.01.18.
//  Copyright © 2018 Sven Bacia. All rights reserved.
//

import XCTest
import Utilities

class NSLayoutConstraintTests: XCTestCase {

    func testWithPriority() {
        let view = UIView()
        let constraint = view.topAnchor.constraint(equalTo: view.topAnchor).with(priority: .required)
        XCTAssertEqual(constraint.priority, .required)
    }
}
