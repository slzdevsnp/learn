//
//  inventoryappTests.swift
//  inventoryappTests
//
//  Created by Brett Romero on 4/24/17.
//  Copyright © 2017 test. All rights reserved.
//

import XCTest

@testable import inventoryapp

class inventoryappTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        if InventoryManager.items.count != 4 {
            InventoryManager.init()
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        InventoryManager.items = []
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testAddItem() {
        let item = InventoryItem(name: "Rogue", units: 5, manufacturerName: "Nissan", dateAdded: "1/1/2017")
        InventoryManager.add(item: item)
        
        XCTAssertEqual(InventoryManager.items.count, 5)
    }
    
    func testAddItem2() {
        let item = InventoryItem(name: "Sentra", units: 5, manufacturerName: "Nissan", dateAdded: "1/1/2017")
        InventoryManager.add(item: item)
        
        XCTAssertEqual(InventoryManager.items.count, 5)
    }
    
    func testAddItemVerifyDetails() {
        let item = InventoryItem(name: "Sentra2", units: 4, manufacturerName: "Nissan", dateAdded: "1/1/2017")
        InventoryManager.add(item: item)
        
        let newItem = InventoryManager.items[InventoryManager.items.count-1]
        
        XCTAssertEqual(newItem.name, "Sentra2")
        XCTAssertEqual(newItem.units, 4)
        XCTAssertEqual(newItem.manufacturerName, "Nissan")
        
    }
    
    func testDeleteItem(){
        InventoryManager.delete(index: 0)
        XCTAssertEqual(InventoryManager.items.count, 3)
    }
}
