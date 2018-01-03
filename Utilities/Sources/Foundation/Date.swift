//
//  Date.swift
//  Utilities
//
//  Created by Sven Bacia on 03.01.18.
//  Copyright © 2018 Sven Bacia. All rights reserved.
//

import Foundation

public extension Date {

    /// Returns the first moment of a given Date, as a Date.
    public var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }

    /// Returns the last moment of a given Date, as a Date.
    public var endOfDay: Date? {
        let components = DateComponents(day: 1, second: -1)
        return Calendar.current.date(byAdding: components, to: startOfDay)
    }

    /// Adds one day to the given Date and returns the new Date.
    public var nextDay: Date? {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)
    }

    /// Returns the number of years since the given Date.
    public var age: Int? {
        return Calendar.current.dateComponents([.year], from: self, to: Date()).year
    }

    /// Returns the day of the given Date.
    public var day: Int {
        return Calendar.current.component(.day, from: self)
    }

    /// Returns the number of days which are between two dates.
    ///
    /// - Parameter to: A date to compare.
    /// - Returns: The number of days between the two dates if possible.
    func numberOfDays(to: Date) -> Int? {
        let fromDateComponents = Calendar.current.dateComponents([.day, .month, .year], from: self)
        let toDateComponents = Calendar.current.dateComponents([.day, .month, .year], from: to)
        return Calendar.current.dateComponents([.day], from: fromDateComponents, to: toDateComponents).day
    }
}
