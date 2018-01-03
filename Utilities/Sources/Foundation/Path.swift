//
//  Path.swift
//  Utilities
//
//  Created by Sven Bacia on 03.01.18.
//  Copyright © 2018 Sven Bacia. All rights reserved.
//

import Foundation

public struct Path {
    /// Returns a URL path to the users documents directory.
    public static var documentsDirectory: URL? {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls.last
    }

    /// Returns a URL path to the private documents directory inside the Library Folder.
    public static var privateDocumentsDirectory: URL? {
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .libraryDirectory, in: .userDomainMask)
        guard let path = urls.last?.appendingPathComponent("Private Documents") else { return nil }

        // check if directory already exists. if not create it.
        if !fileManager.fileExists(atPath: path.path) {
            do {
                try fileManager.createDirectory(at: path, withIntermediateDirectories: true, attributes: nil)
            } catch {
                return nil
            }
        }

        return path
    }

    /// Cache Directory
    public static var cacheDirectory: URL? {
        return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).last
    }

    /// Temporary Directory
    public static var temporaryDirectory: URL {
        return URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
    }
}
