//
//  Array.swift
//  Utilities
//
//  Created by Sven Bacia on 03.01.18.
//  Copyright © 2018 Sven Bacia. All rights reserved.
//

import Foundation

public extension Array where Element: Hashable {

    /// Returns a new array containing the unique elements from the current array.
    public var uniqueElements: [Element] {
        var result = [Element]()
        var memory = Set<Element>()

        for element in self {
            guard !memory.contains(element) else { continue }
            result.append(element)
            memory.insert(element)
        }

        return result
    }
}
