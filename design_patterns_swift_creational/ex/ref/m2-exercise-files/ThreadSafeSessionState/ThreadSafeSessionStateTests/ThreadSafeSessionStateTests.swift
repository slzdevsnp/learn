//
//  ThreadSafeSessionStateTests.swift
//  ThreadSafeSessionStateTests
//
//  Created by Nyisztor, Karoly on 2016. 09. 27..
//  Copyright © 2016. Nyisztor, Karoly. All rights reserved.
//

import XCTest
@testable import ThreadSafeSessionState

class ThreadSafeSessionStateTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testConcurrency() {
        let asyncQueue = DispatchQueue(label: "asyncQueue", attributes: .concurrent, target: nil)
        
        let expect = expectation(description: "Storing values in ThreadSafeSessionState shall succeed")
        
        let MaxIndex = 1000
        
        for index in 0...MaxIndex {
            asyncQueue.async {
                ThreadSafeSessionState.shared.set(index, forKey: String(index))
            }
        }
        
        // wait until the last element is written
        while ThreadSafeSessionState.shared.object(forKey: String(MaxIndex)) as? Int != MaxIndex {
            // nop
        }
        
        expect.fulfill()
        
        waitForExpectations(timeout: 10) { (error) in
            XCTAssertNil(error, "Test expectation failed")
        }
    }
}
