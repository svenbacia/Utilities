//
//  Helper.swift
//  UtilitiesTests
//
//  Created by Sven Bacia on 09.07.18.
//  Copyright © 2018 Sven Bacia. All rights reserved.
//

import CoreData
import Utilities

final class Helper {
	private static let model = NSManagedObjectModel(contentsOf: Bundle(for: Helper.self).url(forResource: "Example", withExtension: "momd")!)!

	static func inMemoryContainer() -> NSPersistentContainer {
		return NSPersistentContainer.inMemoryContainer(name: "Example", managedObjectModel: model)
	}
}
