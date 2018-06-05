//
//  ReusableView.swift
//  Utilities
//
//  Created by Sven Bacia on 03.01.18.
//  Copyright © 2018 Sven Bacia. All rights reserved.
//

// Inspired by https://github.com/AliSoftware/Reusable

import UIKit

// MARK: - ReusableView

/// A reusableView is identified by a `reuseIdentifier`.
public protocol ReusableView: AnyObject {
    /// Identifies a `ReusableView`. The default implementation returns the name of the class as the `reuseIdentifier`.
    static var reuseIdentifier: String { get }
}

public extension ReusableView where Self: UIView {
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
}

// MARK: - SupplementaryView

/// A kind of supplementary view used in a `UICollectionView`.
public enum SupplementaryViewKind {
    case sectionHeader
    case sectionFooter

    /// Identifies the header or footer for a given section in a collection view.
    public var collectionElementKind: String {
        switch self {
        case .sectionHeader:
            return UICollectionView.elementKindSectionHeader
        case .sectionFooter:
            return UICollectionView.elementKindSectionFooter
        }
    }
}

// MARK: - UICollectionView

public extension UICollectionView {

    /// Register a class for use in creating new collection view cells.
    ///
    /// - Parameter cell: The type of class which should be registered.
    public func register<Cell>(_ cell: Cell.Type) where Cell: ReusableView & UICollectionViewCell {
        self.register(cell, forCellWithReuseIdentifier: cell.reuseIdentifier)
    }

    /// Registers a class for use in creating supplementary views for the collection view.
    ///
    /// - Parameters:
    ///   - view: The class to use for the supplementary view.
    ///   - kind: The kind of supplementary view to create.
    public func register<View>(_ view: View.Type, ofKind kind: SupplementaryViewKind) where View: ReusableView & UICollectionReusableView {
        self.register(view, forSupplementaryViewOfKind: kind.collectionElementKind, withReuseIdentifier: view.reuseIdentifier)
    }

    /// Returns a reusable cell object located by its identifier.
    ///
    /// - Parameters:
    ///   - cell: The type of class of the cell.
    ///   - indexPath: The index path specifying the location of the cell.
    /// - Returns: A valid collection view cell of the given type.
    public func dequeue<Cell>(_ cell: Cell.Type, for indexPath: IndexPath) -> Cell where Cell: ReusableView & UICollectionViewCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: cell.reuseIdentifier, for: indexPath) as? Cell else {
            fatalError("Could not dequeue reusable cell with identifier: \(Cell.reuseIdentifier)")
        }
        return cell
    }

    /// Returns a reusable supplementary view located by its identifier and kind.
    ///
    /// - Parameters:
    ///   - supplementaryView: The type of class of the supplementary view.
    ///   - kind: The kind of supplementary view to retrieve.
    ///   - indexPath: The index path specifying the location of the supplementary view in the collection view.
    /// - Returns: A valid supplementary view of the given type.
    public func dequeue<View>(_ supplementaryView: View.Type, ofKind kind: SupplementaryViewKind, for indexPath: IndexPath) -> View where View: ReusableView & UICollectionReusableView {
        guard let view = dequeueReusableSupplementaryView(ofKind: kind.collectionElementKind, withReuseIdentifier: View.reuseIdentifier, for: indexPath) as? View else {
            fatalError("Could not dequeue reusable supplementary view with identifier: \(View.reuseIdentifier)")
        }
        return view
    }
}

// MARK: - UITableView

public extension UITableView {

    /// Register a class for use in creating new table view cells.
    ///
    /// - Parameter cell: The type of class which should be registered.
    public func register<Cell>(_ cell: Cell.Type) where Cell: ReusableView & UITableViewCell {
        self.register(cell, forCellReuseIdentifier: cell.reuseIdentifier)
    }

    /// Registers a class for use in creating header/footer views for the table view.
    ///
    /// - Parameters:
    ///   - view: The class to use for the header/footer view.
    public func register<HeaderFooter>(_ headerFooter: HeaderFooter.Type) where HeaderFooter: ReusableView & UITableViewHeaderFooterView {
        self.register(headerFooter.self, forHeaderFooterViewReuseIdentifier: headerFooter.reuseIdentifier)
    }

    /// Returns a reusable cell object located by its identifier.
    ///
    /// - Parameters:
    ///   - cell: The type of class of the cell.
    ///   - indexPath: The index path specifying the location of the cell.
    /// - Returns: A valid table view cell of the given type.
    public func dequeue<Cell>(_ cell: Cell.Type, for indexPath: IndexPath) -> Cell where Cell: ReusableView & UITableViewCell {
        guard let cell = dequeueReusableCell(withIdentifier: cell.reuseIdentifier, for: indexPath) as? Cell else {
            fatalError("Could not dequeue reusable cell with identifier: \(Cell.reuseIdentifier)")
        }
        return cell
    }

    /// Returns a reusable header/footer view located by its identifier.
    ///
    /// - Parameter headerFooter: The class of the header/footer view.
    /// - Returns: A valid table view header footer view of the given type.
    public func dequeue<HeaderFooter>(_ headerFooter: HeaderFooter.Type) -> HeaderFooter where HeaderFooter: ReusableView & UITableViewHeaderFooterView {
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: headerFooter.reuseIdentifier) as? HeaderFooter else {
            fatalError("Could not dequeue reusable header footer view with identifier: \(headerFooter.reuseIdentifier)")
        }
        return view
    }
}
