//
//  Int.swift
//  Utilities
//
//  Created by Sven Bacia on 03.01.18.
//  Copyright © 2018 Sven Bacia. All rights reserved.
//

import Foundation

public extension Int {
    /// Calculates a random number between a lower (including) and an upper bound (excluding).
    ///
    /// - Parameters:
    ///   - lowerBound: The lower bound.
    ///   - upperBound: The upper bound.
    /// - Returns: Returns the random number between the lower and upper bound.
    public static func randomNumber(between lowerBound: Int, and upperBound: Int) -> Int {
        let upper = abs(upperBound - lowerBound)
        let lower = Swift.min(upperBound, lowerBound)
        return Int(arc4random_uniform(UInt32(upper))) + lower
    }
}
