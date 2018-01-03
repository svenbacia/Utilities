//
//  NSLayoutConstraint.swift
//  Utilities
//
//  Created by Sven Bacia on 03.01.18.
//  Copyright © 2018 Sven Bacia. All rights reserved.
//

import UIKit

public extension NSLayoutConstraint {
    /// Sets the priority of the given `NSLayoutConstraint`.
    ///
    /// - Parameter priority: The priorty.
    /// - Returns: Returns itself.
    public func with(priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
}
