//
//  DateTests.swift
//  UtilitiesTests
//
//  Created by Sven Bacia on 03.01.18.
//  Copyright © 2018 Sven Bacia. All rights reserved.
//

import XCTest
import Utilities

class DateTests: XCTestCase {

    // MARK: - Properties

    private let formatter = ISO8601DateFormatter()

    // MARK: - Tests

    func testStartOfDay() {
        XCTAssertEqual(date().startOfDay, startOfDay())
    }

    func testEndOfDay() {
        XCTAssertEqual(date().endOfDay, endOfDay())
    }

    func testNextDay() {
        XCTAssertEqual(date().nextDay, nextDay())
    }

    func testDay() {
        XCTAssertEqual(date().day, 3)
    }

    func testAge() {
        XCTAssertEqual(tenYearsAgo().age, 10)
    }

    func testNumberOfDaysBetween() {
        XCTAssertEqual(date().numberOfDays(to: nextWeek()), 7)
        XCTAssertEqual(date().numberOfDays(to: nextWeekLater()), 7)
        XCTAssertEqual(date().numberOfDays(to: nextDay()), 1)
        XCTAssertEqual(date().addingTimeInterval(3600).numberOfDays(to: nextDay()), 1)
    }

    // MARK: - Helper

    private func date() -> Date {
        let format = "2018-01-03T13:00:00+01:00"
        return formatter.date(from: format)!
    }

    private func nextWeek() -> Date {
        let format = "2018-01-10T12:00:00+01:00"
        return formatter.date(from: format)!
    }

    private func nextWeekLater() -> Date {
        let format = "2018-01-10T14:00:00+01:00"
        return formatter.date(from: format)!
    }

    private func startOfDay() -> Date {
        let format = "2018-01-03T00:00:00+01:00"
        return formatter.date(from: format)!
    }

    private func endOfDay() -> Date {
        let format = "2018-01-03T23:59:59+01:00"
        return formatter.date(from: format)!
    }

    private func nextDay() -> Date {
        let format = "2018-01-04T13:00:00+01:00"
        return formatter.date(from: format)!
    }

    private func tenYearsAgo() -> Date {
        let format = "2008-01-03T10:00:00+01:00"
        return formatter.date(from: format)!
    }
}
