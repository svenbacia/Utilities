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

    private let queue: OperationQueue
    private let notificationCenter: NotificationCenter

    private var observers = [NSObjectProtocol]()

    // MARK: - Init

    public init(notificationCenter: NotificationCenter = .default, queue: OperationQueue = .main) {
        self.notificationCenter = notificationCenter
        self.queue = queue
    }

    deinit {
        for observer in observers {
            notificationCenter.removeObserver(observer)
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
        let observer = notificationCenter.addObserver(forName: name, object: nil, queue: queue, using: handler)
        observers.append(observer)
    }
}
