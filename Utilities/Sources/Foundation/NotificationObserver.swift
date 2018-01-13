//
//  NotificationObserver.swift
//  Utilities
//
//  Created by Sven Bacia on 13.01.18.
//  Copyright © 2018 Sven Bacia. All rights reserved.
//
// https://twitter.com/jaredsinclair/status/951536021459619840

import Foundation

public class NotificationObserver {

    // MARK: - Properties

    private var observers = [NSObjectProtocol]()
    private let queue: OperationQueue

    // MARK: - Init

    public init(queue: OperationQueue = .main) {
        self.queue = queue
    }

    deinit {
        for observer in observers {
            NotificationCenter.default.removeObserver(observer)
        }
    }

    // MARK: - Action

    /// Adds an entry to the notification center's dispatch table that includes a notification name and a block to add to the queue.
    /// All observers will be removed when the `NotificationObserver` is released.
    ///
    /// - Parameters:
    ///   - name: The notification name.
    ///   - handler: The block to be executed when the notification is received.
    public func when(_ name: Notification.Name, perform handler: @escaping (Notification) -> Void) {
        let observer = NotificationCenter.default.addObserver(forName: name, object: nil, queue: queue, using: handler)
        observers.append(observer)
    }
}
