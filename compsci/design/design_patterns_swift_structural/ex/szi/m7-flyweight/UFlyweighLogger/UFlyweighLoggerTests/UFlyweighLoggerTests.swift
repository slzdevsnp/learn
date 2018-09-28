//
//  UFlyweighLoggerTests.swift
//  UFlyweighLoggerTests
//
//  Created by Sviatoslav Zimine on 9/25/17.
//  Copyright © 2017 sviatoslav.zimin. All rights reserved.
//

import XCTest
@testable import UFlyweighLogger

class UFlyweighLoggerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testIsFlyweightUnique() {
        let subsystem = "com.pluralsight.test"
        let category = "UnitTest"
        //the factory ensures that the same object is returned
        //if its intrinsic state is the same (subsustem + category)
        if let logger = FlyweightLoggerFactory.shared.logger(subsystem: subsystem, category: category) {
            let logger2 = FlyweightLoggerFactory.shared.logger(subsystem: subsystem, category: category)
            XCTAssertTrue(logger === logger2, "Should be the same logger instance")
        } else {
            XCTFail("Could not instantiate logger")
        }
    }
    
}
