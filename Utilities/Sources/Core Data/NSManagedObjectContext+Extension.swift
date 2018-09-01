//
//  NSManagedObjectContext+Extension.swift
//  Utilities
//
//  Created by Sven Bacia on 21.06.18.
//  Copyright © 2018 Sven Bacia. All rights reserved.
//

import CoreData

extension NSManagedObjectContext {

    public func insertObject<Item>() -> Item where Item: Managed & NSManagedObject {
        guard let object = NSEntityDescription.insertNewObject(forEntityName: Item.entityName, into: self) as? Item else {
            fatalError("unexpected entity type")
        }
        return object
    }

    @discardableResult
    public func saveOrRollback() -> Bool {
        do {
            try save()
            return true
        } catch {
            rollback()
            return false
        }
    }

    public func performSaveOrRollback() {
        perform {
            self.saveOrRollback()
        }
    }

    public func performChanges(_ changes: @escaping () -> Void) {
        perform {
            changes()
            self.saveOrRollback()
        }
    }
}
