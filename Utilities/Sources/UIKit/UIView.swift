//
//  UIView.swift
//  Utilities
//
//  Created by Sven Bacia on 03.01.18.
//  Copyright © 2018 Sven Bacia. All rights reserved.
//

import UIKit

public extension UIView {

    // MARK: - UIImage

    /// Returns an image from the current view.
    public var asImage: UIImage {
        let renderer = UIGraphicsImageRenderer(size: bounds.size)
        return renderer.image { _ in
            drawHierarchy(in: bounds, afterScreenUpdates: true)
        }
    }

    // MARK: - Auto Layout

    /// Fills the current view in the given view with optional edge insets.
    ///
    /// - Parameters:
    ///   - view: The containing view.
    ///   - inset: An optional inset.
    public func fill(`in` view: UIView, inset: NSDirectionalEdgeInsets = .zero) {
        self.topAnchor.constraint(equalTo: topAnchor, constant: inset.top).isActive = true
        self.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset.leading).isActive = true
        self.bottomAnchor.constraint(equalTo: bottomAnchor, constant: inset.bottom).isActive = true
        self.trailingAnchor.constraint(equalTo: trailingAnchor, constant: inset.trailing).isActive = true
    }

    /// Fills the current view in the given view along the layout guide with optional edge insets.
    ///
    /// - Parameters:
    ///   - view: The containing view.
    ///   - layoutGuide: The layout guide.
    ///   - inset: An optional inset.
    public func fill(`in` view: UIView, layoutGuide: UILayoutGuide, inset: NSDirectionalEdgeInsets = .zero) {
        self.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: inset.top).isActive = true
        self.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: inset.leading).isActive = true
        self.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: inset.bottom).isActive = true
        self.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: inset.trailing).isActive = true
    }
}
