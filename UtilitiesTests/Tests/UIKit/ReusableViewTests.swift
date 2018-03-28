//
//  ReusableViewTests.swift
//  UtilitiesTests
//
//  Created by Sven Bacia on 03.01.18.
//  Copyright © 2018 Sven Bacia. All rights reserved.
//

import XCTest
import Utilities

class ReusableViewTests: XCTestCase {

    private let viewController = ViewController()

    func testTableViewCell() {
        let cell = viewController.tableView(viewController.tableView, cellForRowAt: .zero)
        XCTAssertEqual(cell.reuseIdentifier, TableViewCell.reuseIdentifier)
    }

    func testHeaderFooterView() {
        guard let headerFooterView = viewController.tableView(viewController.tableView, viewForHeaderInSection: 0) as? HeaderFooterView else {
            XCTFail("expected header footer view class")
            return
        }
        XCTAssertEqual(headerFooterView.reuseIdentifier, HeaderFooterView.reuseIdentifier)
    }

    func testCollectionViewCell() {
        let cell = viewController.collectionView(viewController.collectionView, cellForItemAt: .zero)
        XCTAssertEqual(cell.reuseIdentifier, CollectionViewCell.reuseIdentifier)
    }

    func testCollectionViewSupplementaryView_Header() {
        XCTAssertEqual(viewController.collectionView.numberOfItems(inSection: 0), 2)
        let header = viewController.collectionView(viewController.collectionView, viewForSupplementaryElementOfKind: UICollectionElementKindSectionHeader, at: .zero)
        XCTAssertEqual(header.reuseIdentifier, HeaderFooterCollectionViewCell.reuseIdentifier)
    }

    func testCollectionViewSupplementaryView_Footer() {
        XCTAssertEqual(viewController.collectionView.numberOfItems(inSection: 0), 2)
        let header = viewController.collectionView(viewController.collectionView, viewForSupplementaryElementOfKind: UICollectionElementKindSectionFooter, at: .zero)
        XCTAssertEqual(header.reuseIdentifier, HeaderFooterCollectionViewCell.reuseIdentifier)
    }
}

// MARK: - Helper

private final class TableViewCell: UITableViewCell, ReusableView {}
private final class HeaderFooterView: UITableViewHeaderFooterView, ReusableView {}

private final class CollectionViewCell: UICollectionViewCell, ReusableView {}
private final class HeaderFooterCollectionViewCell: UICollectionViewCell, ReusableView {}

private final class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate {

    let tableView: UITableView = {
        return UITableView(frame: CGRect(x: 0, y: 0, width: 320, height: 480), style: .plain)
    }()

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.headerReferenceSize = CGSize(width: 320, height: 44)
        return UICollectionView(frame: CGRect(x: 0, y: 0, width: 320, height: 480), collectionViewLayout: layout)
    }()

    // MARK: - Init

    public init() {
        super.init(nibName: nil, bundle: nil)

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CollectionViewCell.self)
        collectionView.register(HeaderFooterCollectionViewCell.self, ofKind: .sectionHeader)
        collectionView.register(HeaderFooterCollectionViewCell.self, ofKind: .sectionFooter)

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TableViewCell.self)
        tableView.register(HeaderFooterView.self)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func loadView() {
        super.loadView()
        view.addSubview(collectionView)
        view.addSubview(tableView)
    }

    // MARK: - UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeue(CollectionViewCell.self, for: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return collectionView.dequeue(HeaderFooterCollectionViewCell.self, ofKind: .sectionHeader, for: indexPath)
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeue(TableViewCell.self, for: .zero)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableView.dequeue(HeaderFooterView.self)
    }
}
