//
//  PersistentContainerTests.swift
//  UtilitiesTests
//
//  Created by Sven Bacia on 07.07.18.
//  Copyright © 2018 Sven Bacia. All rights reserved.
//

import XCTest
import CoreData
import Utilities

class PersistentContainerTests: XCTestCase {

    override func setUp() {
        super.setUp()
        PersistentContainer.directoryURL = nil
    }

    func testDefaultDirectoryURL() {
        PersistentContainer.directoryURL = nil
        XCTAssertEqual(PersistentContainer.defaultDirectoryURL(), NSPersistentContainer.defaultDirectoryURL())

        PersistentContainer.directoryURL = URL(fileURLWithPath: "/some/path")
        XCTAssertEqual(URL(fileURLWithPath: "/some/path"), PersistentContainer.directoryURL)
        XCTAssertEqual(URL(fileURLWithPath: "/some/path"), PersistentContainer.defaultDirectoryURL())
    }

	func testTemporaryContainer() {
		_ = PersistentContainer.temporaryContainer(name: "Example", bundle: Bundle(for: type(of: self).self))
		// after creating a temporary container, the default url should point to the tmp directory
		XCTAssertTrue(PersistentContainer.defaultDirectoryURL().path.contains("/tmp/"))
	}
}
