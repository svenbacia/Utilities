//
//  Bool.swift
//  Utilities
//
//  Created by Sven Bacia on 03.01.18.
//  Copyright © 2018 Sven Bacia. All rights reserved.
//

import Foundation

public extension Bool {

    /// Toggles the current value.
    public mutating func toggle() {
        self = !self
    }

    /// Toggles the current value.
    public func toggled() -> Bool {
        return !self
    }
}
