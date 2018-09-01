//
//  NSPersistentContainer+Extension.swift
//  Utilities
//
//  Created by Bacia, Sven on 28.06.18.
//  Copyright © 2018 Sven Bacia. All rights reserved.
//

import CoreData

extension NSPersistentContainer {
    public static func inMemoryContainer(name: String, bundle: Bundle = .main) -> NSPersistentContainer {
        guard let url = bundle.url(forResource: name, withExtension: "momd") else { fatalError("invalid url") }
        guard let model = NSManagedObjectModel(contentsOf: url) else { fatalError("invalid model") }
		return inMemoryContainer(name: name, managedObjectModel: model)
    }

	public static func inMemoryContainer(name: String, managedObjectModel: NSManagedObjectModel) -> NSPersistentContainer {
		let container = NSPersistentContainer(name: name, managedObjectModel: managedObjectModel)
		let description = NSPersistentStoreDescription()
		description.type = NSInMemoryStoreType
		description.configuration = "Default"
		container.persistentStoreDescriptions = [description]
		return container
	}
}

public final class PersistentContainer: NSPersistentContainer {

    // MARK: - Properties

    public static var directoryURL: URL?

    public override static func defaultDirectoryURL() -> URL {
        guard let url = directoryURL else { return super.defaultDirectoryURL() }
        return url
    }

    public static func temporaryContainer(name: String, bundle: Bundle = .main) -> NSPersistentContainer {
        let url = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(UUID().uuidString)
        let container = PersistentContainer(name: name, bundle: bundle, directoryURL: url)
        return container
    }

    // MARK: - Init

    public init(name: String, bundle: Bundle = .main, directoryURL: URL? = nil) {
        type(of: self).directoryURL = directoryURL
        guard let url = bundle.url(forResource: name, withExtension: "momd") else { fatalError("invalid url") }
        guard let model = NSManagedObjectModel(contentsOf: url) else { fatalError("invalid model") }
        super.init(name: name, managedObjectModel: model)
    }
}
