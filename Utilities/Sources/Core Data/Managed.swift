//
//  Managed.swift
//  Utilities
//
//  Created by Sven Bacia on 21.06.18.
//  Copyright © 2018 Sven Bacia. All rights reserved.
//

import CoreData

public protocol Managed: AnyObject, NSFetchRequestResult {
    static var entityName: String { get }
    static var defaultSortDescriptors: [NSSortDescriptor] { get }
    static var defaultPredicate: NSPredicate { get }
    var managedObjectContext: NSManagedObjectContext? { get }
}

extension Managed {

    public static var defaultSortDescriptors: [NSSortDescriptor] {
        return []
    }

    public static var defaultPredicate: NSPredicate {
        return NSPredicate(value: true)
    }

    public static var sortedFetchRequest: NSFetchRequest<Self> {
        let request = NSFetchRequest<Self>(entityName: entityName)
        request.sortDescriptors = defaultSortDescriptors
        request.predicate = defaultPredicate
        return request
    }

    public static func sortedFetchRequest(with predicate: NSPredicate) -> NSFetchRequest<Self> {
        let request = sortedFetchRequest
        guard let existingPredicate = request.predicate else { fatalError("Expected existing default predicate") }
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [existingPredicate, predicate])
        return request
    }
}

extension Managed where Self: NSManagedObject {

    public static var entityName: String {
		guard let name = entity().name else { fatalError("expected entity name") }
		return name
    }

    public static func findOrCreate(in context: NSManagedObjectContext, matching predicate: NSPredicate, configure: (Self) -> Void) -> Self {
        if let object = findOrFetch(in: context, matching: predicate) {
            return object
        }
		
		let object: Self = context.insertObject()
		configure(object)
		return object
    }

    public static func findOrFetch(in context: NSManagedObjectContext, matching predicate: NSPredicate) -> Self? {
        if let object = materializedObject(in: context, matching: predicate) {
            return object
        } else {
            return fetch(in: context) { (request) in
                request.predicate = predicate
                request.returnsObjectsAsFaults = false
                request.fetchLimit = 1
            }.first
        }
    }

    public static func fetch(in context: NSManagedObjectContext, configure: (NSFetchRequest<Self>) -> Void = { _ in }) -> [Self] {
        let request = NSFetchRequest<Self>(entityName: entityName)
        configure(request)
        do {
            return try context.fetch(request)
        } catch {
            fatalError("Fetch request failed. \(error)")
        }
    }

    public static func count(in context: NSManagedObjectContext, configure: (NSFetchRequest<Self>) -> Void = { _ in }) -> Int {
        let request = NSFetchRequest<Self>(entityName: entityName)
        configure(request)
        do {
            return try context.count(for: request)
        } catch {
            fatalError("Count request failed. \(error)")
        }
    }

    public static func materializedObject(in context: NSManagedObjectContext, matching predicate: NSPredicate) -> Self? {
        for object in context.registeredObjects where !object.isFault {
            guard let result = object as? Self, predicate.evaluate(with: result) else { continue }
            return result
        }
        return nil
    }
}
