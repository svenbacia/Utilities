//
//  ManagedTests.swift
//  UtilitiesTests
//
//  Created by Sven Bacia on 08.07.18.
//  Copyright © 2018 Sven Bacia. All rights reserved.
//

import XCTest
import CoreData
import Utilities

class ManagedTests: XCTestCase {

	private var container: NSPersistentContainer!

	override func setUp() {
		super.setUp()
		container = Helper.inMemoryContainer()
	}

	override func tearDown() {
		container = nil
		super.tearDown()
	}

	func testManagedDefaultPropertiesWithInMemoryContext() {
		let expectation = self.expectation(description: "expects default properties")
		container.loadPersistentStores { (_, error) in
			if let error = error {
				XCTFail(error.localizedDescription)
			}

			XCTAssertEqual(Example.defaultSortDescriptors, [])
			XCTAssertEqual(Example.defaultPredicate, NSPredicate(value: true))
			XCTAssertEqual(Example.entityName, "Example")

			let request = Example.sortedFetchRequest
			XCTAssertTrue(request.sortDescriptors!.isEmpty)
			XCTAssertEqual(request.predicate, NSPredicate(value: true))

			let requestWithPredicate = Example.sortedFetchRequest(with: NSPredicate(value: false))
			XCTAssertTrue(request.sortDescriptors!.isEmpty)
			XCTAssertEqual(requestWithPredicate.predicate, NSCompoundPredicate.init(andPredicateWithSubpredicates: [
				NSPredicate(value: true),
				NSPredicate(value: false)
				]))

			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 1)
	}

	func testFindOrFetchToReturnNil() {
		let expectation = self.expectation(description: "expects nil")
		container.loadPersistentStores { (_, error) in
			if let error = error {
				XCTFail(error.localizedDescription)
			}

			let example = Example.findOrFetch(in: self.self.container.viewContext, matching: NSPredicate(value: true))
			XCTAssertNil(example)

			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 1)
	}

	func testFindOrFetchToReturnValue() {
		let expectation = self.expectation(description: "expects nil")
		container.loadPersistentStores { (_, error) in
			if let error = error {
				XCTFail(error.localizedDescription)
			}

			let example: Example = self.self.container.viewContext.insertObject()
			example.title = "Example"

			XCTAssertTrue(self.self.container.viewContext.saveOrRollback())

			let result = Example.findOrFetch(in: self.self.container.viewContext, matching: NSPredicate(format: "%K == %@", #keyPath(Example.title), "Example"))
			XCTAssertNotNil(result)
			XCTAssertEqual(result!.title!, example.title!)

			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 1)
	}

	func testCount() {
		let expectation = self.expectation(description: "expects nil")
		container.loadPersistentStores { (_, error) in
			if let error = error {
				XCTFail(error.localizedDescription)
			}

			XCTAssertEqual(Example.count(in: self.container.viewContext), 0)

			let example: Example = self.self.container.viewContext.insertObject()
			example.title = "Example"

			XCTAssertTrue(self.self.container.viewContext.saveOrRollback())
			XCTAssertEqual(Example.count(in: self.container.viewContext), 1)

			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 1)
	}

	func testFindOrCreate() {
		let expectation = self.expectation(description: "expects nil")
		container.loadPersistentStores { (_, error) in
			if let error = error {
				XCTFail(error.localizedDescription)
			}

			let title = "Title"
			let create = Example.findOrCreate(in: self.container.viewContext,
											  matching: NSPredicate(format: "%K == %@", #keyPath(Example.title), title),
											  configure: { (example) in
												example.title = title
			})
			XCTAssertEqual(create.title!, "Title")
			XCTAssertTrue(self.container.viewContext.saveOrRollback())

			let other = Example.findOrCreate(in: self.container.viewContext,
											 matching: NSPredicate(format: "%K == %@", #keyPath(Example.title), title),
											 configure: { (example) in
												example.title = title
			})
			XCTAssertEqual(create, other)
			XCTAssertEqual(Example.count(in: self.container.viewContext), 1)

			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 1)
	}
}
