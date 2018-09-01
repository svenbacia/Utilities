//
//  NSPersistentContainerTests.swift
//  UtilitiesTests
//
//  Created by Sven Bacia on 07.07.18.
//  Copyright © 2018 Sven Bacia. All rights reserved.
//

import XCTest
import Utilities
import CoreData

class NSPersistentContainerTests: XCTestCase {

	var container: NSPersistentContainer!

	override func setUp() {
		super.setUp()
		container = Helper.inMemoryContainer()
	}

	override func tearDown() {
		container = nil
		super.tearDown()
	}

    func testInMemoryContainer() {
        let expectation = self.expectation(description: "expects in memory store type")
        container.loadPersistentStores { (description, error) in
            XCTAssertNil(error)
            XCTAssertEqual(description.type, NSInMemoryStoreType)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
}
