//
//  ArrayDataSourceTests.swift
//
// Created by Kirby Turner.
// Copyright 2016 White Peak Software. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining
// a copy of this software and associated documentation files (the
// "Software"), to deal in the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to permit
// persons to whom the Software is furnished to do so, subject to the
// following conditions:
//
// The above copyright notice and this permission notice shall be included
// in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
// OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
// CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
// TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
// SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

import XCTest
@testable import WPSKit

class ArrayDataSourceTests: XCTestCase {

  override func setUp() {
    super.setUp()
  }
}

extension ArrayDataSourceTests {

  func testDataSource_objectAtIndexPath() {
    let dataSource = ArrayDataSource()
    dataSource.array = [["One", "Two"], ["Three", "Four"]]
    XCTAssertEqual((dataSource.objectAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as? String), "One", "Should be 'One'.")
    XCTAssertEqual((dataSource.objectAtIndexPath(NSIndexPath(forRow: 1, inSection: 0)) as? String), "Two", "Should be 'Two'.")
    XCTAssertEqual((dataSource.objectAtIndexPath(NSIndexPath(forRow: 0, inSection: 1)) as? String), "Three", "Should be 'Three'.")
    
    XCTAssertNil((dataSource.objectAtIndexPath(NSIndexPath(forRow: 3, inSection: 5)) as? String), "Should be nil.")
  }
  
}

extension ArrayDataSourceTests {
  
  func testCollectionView_numberOfSections() {
    let dataSource = ArrayDataSource()
    dataSource.array = [["One", "Two"], ["Three", "Four"]]
    
    let collectionLayout = UICollectionViewFlowLayout()
    let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: collectionLayout)
    collectionView.dataSource = dataSource
    collectionView.reloadData()
    
    XCTAssertEqual(collectionView.numberOfSections(), 2, "Should have 2 sections.")
  }
  
  func testCollectionView_numberOfRowsInSections() {
    let dataSource = ArrayDataSource()
    dataSource.array = [["One", "Two", "Three", "Four"], ["Five"]]
    
    let collectionLayout = UICollectionViewFlowLayout()
    let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: collectionLayout)
    collectionView.dataSource = dataSource
    collectionView.reloadData()
    
    XCTAssertEqual(collectionView.numberOfItemsInSection(0), 4, "Should have 4 rows in section 0.")
    XCTAssertEqual(collectionView.numberOfItemsInSection(1), 1, "Should have 1 row in section 1.")
  }
  
  func testCollectionView_configureCell() {
    let dataSource = ArrayDataSource(defaultCellIdentifier: "id")
    dataSource.array = [["One"]]
    
    var callCount = 0
    
    dataSource.configureCell = { (cell, indexPath, item) in
      XCTAssertEqual(String(item), "One", "Should be 'One'.")
      callCount = callCount + 1
    }
    
    let collectionLayout = UICollectionViewFlowLayout()
    let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: collectionLayout)
    collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "id")
    collectionView.dataSource = dataSource
    collectionView.reloadData()
    
    let cell = dataSource.collectionView(collectionView, cellForItemAtIndexPath: NSIndexPath(forItem: 0, inSection: 0))
    
    XCTAssertNotNil(cell, "Should have a cell.")
    XCTAssertEqual(callCount, 1, "Should call configureCell 1 time.")
  }
  
}

extension ArrayDataSourceTests {

  func testTableView_numberOfSections() {
    let dataSource = ArrayDataSource()
    dataSource.array = [["One", "Two"], ["Three", "Four"]]
    
    let tableView = UITableView()
    tableView.dataSource = dataSource
    tableView.reloadData()
    
    XCTAssertEqual(tableView.numberOfSections, 2, "Should have 2 sections.")
  }

  func testTableView_numberOfRowsInSections() {
    let dataSource = ArrayDataSource()
    dataSource.array = [["One", "Two", "Three", "Four"], ["Five"]]
    
    let tableView = UITableView()
    tableView.dataSource = dataSource
    tableView.reloadData()
    
    XCTAssertEqual(tableView.numberOfRowsInSection(0), 4, "Should have 4 rows in section 0.")
    XCTAssertEqual(tableView.numberOfRowsInSection(1), 1, "Should have 1 row in section 1.")
  }

  func testTableView_defaultCellIdentifier() {
    let dataSource = ArrayDataSource(defaultCellIdentifier: "id")
    dataSource.array = [["One"]]
    
    let tableView = UITableView()
    tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "id")
    tableView.dataSource = dataSource
    tableView.reloadData()
    
    let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0))
    
    XCTAssertNotNil(cell, "Should have a cell.")
  }

  func testTableView_cellIdentifierClosure() {
    let dataSource = ArrayDataSource()
    dataSource.array = [["One"]]
    
    var callCount = 0
    dataSource.cellIdentifier = { (indexPath, item) in
      callCount += 1
      return "id"
    }
    
    let tableView = UITableView()
    tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "id")
    tableView.dataSource = dataSource
    tableView.reloadData()
    
    let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0))
    
    XCTAssertNotNil(cell, "Should have a cell.")
  }
  
  func testTableView_configureCell() {
    let dataSource = ArrayDataSource(defaultCellIdentifier: "id")
    dataSource.array = [["One"]]
    
    var callCount = 0
    
    dataSource.configureCell = { (cell, indexPath, item) in
      XCTAssertEqual(String(item), "One", "Should be 'One'.")
      callCount = callCount + 1
    }
    
    let tableView = UITableView()
    tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "id")
    tableView.dataSource = dataSource
    tableView.reloadData()
    
    let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0))
    
    XCTAssertNotNil(cell, "Should have a cell.")
    XCTAssertEqual(callCount, 1, "Should call configureCell 1 time.")
  }
  
  func testTableView_sectionHeaderTitle() {
    let dataSource = ArrayDataSource(defaultCellIdentifier: "id", sectionHeaderTitles: ["Header One"])
    dataSource.array = [["One"]]
    
    let tableView = UITableView()
    tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "id")
    tableView.dataSource = dataSource
    tableView.reloadData()
    
    let title = dataSource.tableView(tableView, titleForHeaderInSection: 0)
    XCTAssertEqual(title, "Header One", "Should have header title 'Header One'.")
  }

  func testTableView_canEditRowNoEdits() {
    let dataSource = ArrayDataSource(defaultCellIdentifier: "id")
    dataSource.array = [["One", "Two"]]

    let tableView = UITableView()
    tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "id")
    tableView.dataSource = dataSource
    tableView.reloadData()

    XCTAssertFalse(dataSource.tableView(tableView, canEditRowAtIndexPath: NSIndexPath(forRow: 0, inSection: 0)), "Should not be able to edit.")
    XCTAssertFalse(dataSource.tableView(tableView, canEditRowAtIndexPath: NSIndexPath(forRow: 1, inSection: 0)), "Should not be able to edit.")
  }

  func testTableView_canEditRow() {
    let dataSource = ArrayDataSource(defaultCellIdentifier: "id")
    dataSource.array = [["One", "Two"]]
    
    dataSource.canEdit = { (indexPath) in
      if indexPath.row == 1 {
        return true
      } else {
        return false
      }
    }
    
    let tableView = UITableView()
    tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "id")
    tableView.dataSource = dataSource
    tableView.reloadData()
    
    XCTAssertFalse(dataSource.tableView(tableView, canEditRowAtIndexPath: NSIndexPath(forRow: 0, inSection: 0)), "Should not be able to edit row 0.")
    XCTAssertTrue(dataSource.tableView(tableView, canEditRowAtIndexPath: NSIndexPath(forRow: 1, inSection: 0)), "Should be able to edit row 1.")
  }

  func testTableView_commitEditingStyle() {
    let dataSource = ArrayDataSource(defaultCellIdentifier: "id")
    dataSource.array = [["One", "Two"]]
  
    var callCount = 0
    dataSource.commitEditingStyle = { (tableView, editingStyle, indexPath) in
      callCount += 1
    }
    
    let tableView = UITableView()
    tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "id")
    tableView.dataSource = dataSource
    tableView.reloadData()

    dataSource.tableView(tableView, editingStyle: .Insert, forRowAtIndexPath: NSIndexPath(forRow: 0, inSection: 0))
    XCTAssertEqual(callCount, 1, "Call count should be 1.")
  }

  func testTableView_canMoveRowNo() {
    let dataSource = ArrayDataSource(defaultCellIdentifier: "id")
    dataSource.array = [["One", "Two"]]
    
    let tableView = UITableView()
    tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "id")
    tableView.dataSource = dataSource
    tableView.reloadData()
    
    XCTAssertFalse(dataSource.tableView(tableView, canMoveRowAtIndexPath: NSIndexPath(forRow: 0, inSection: 0)), "Should not be able to move.")
    XCTAssertFalse(dataSource.tableView(tableView, canMoveRowAtIndexPath: NSIndexPath(forRow: 1, inSection: 0)), "Should not be able to move.")
  }

  func testTableView_canMoveRow() {
    let dataSource = ArrayDataSource(defaultCellIdentifier: "id")
    dataSource.array = [["One", "Two"]]
    
    dataSource.canMoveItem = { (indexPath) in
      if indexPath.row == 1 {
        return true
      } else {
        return false
      }
    }
    
    let tableView = UITableView()
    tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "id")
    tableView.dataSource = dataSource
    tableView.reloadData()
    
    XCTAssertFalse(dataSource.tableView(tableView, canMoveRowAtIndexPath: NSIndexPath(forRow: 0, inSection: 0)), "Should not be able to move row 0.")
    XCTAssertTrue(dataSource.tableView(tableView, canMoveRowAtIndexPath: NSIndexPath(forRow: 1, inSection: 0)), "Should be able to move row 1.")
  }

  func testTableView_moveItem() {
    let dataSource = ArrayDataSource(defaultCellIdentifier: "id")
    dataSource.array = [["One", "Two"]]
    
    var callCount = 0
    dataSource.moveItem = { (tableView, sourceIndexPath, destinationIndexPath) in
      callCount += 1
    }
    
    let tableView = UITableView()
    tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "id")
    tableView.dataSource = dataSource
    tableView.reloadData()
    
    dataSource.tableView(tableView, moveRowAtIndexPath: NSIndexPath(forRow: 0, inSection: 0), toIndexPath: NSIndexPath(forRow: 1, inSection: 0))
    XCTAssertEqual(callCount, 1, "Call count should be 1.")
  }
  
}
