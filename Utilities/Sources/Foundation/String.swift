//
//  String.swift
//  Utilities
//
//  Created by Sven Bacia on 03.01.18.
//  Copyright © 2018 Sven Bacia. All rights reserved.
//

import Foundation

public extension String {
    /// Returns a URL from the given String.
    public var asUrl: URL? {
        return URL(string: self)
    }
}
