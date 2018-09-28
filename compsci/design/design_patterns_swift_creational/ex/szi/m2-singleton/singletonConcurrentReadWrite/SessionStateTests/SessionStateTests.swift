//
//  SessionStateTests.swift
//  SessionStateTests
//
//  Created by Sviatoslav Zimine on 9/23/17.
//  Copyright © 2017 sviatoslav.zimin. All rights reserved.
//

import XCTest
@testable import SessionState

class SessionStateTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testConcurrentAccess() {
        let dts = Date()
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let asyncQueue = DispatchQueue(label: "asyncQueue",  attributes: .concurrent, target: nil)
        //XCTest framework
        let expect = expectation(description: "Storing values in SessionState shall succeed")
        let MaxIndex = 1000000
        
        for index in 0...MaxIndex{
            asyncQueue.async { // access session state in many threads
                SessionState.shared.set(index, forKey: String(index))
                //observe the order of index values in the log
                // modify asyncQueue to asyncQueue.sync and rerun
                
                //print("put to session state index: \(index)")
            }
        }
        
        //wait until the last element is written
        while SessionState.shared.object(forKey: String(MaxIndex)) != MaxIndex {
            //nop
        }
        
        expect.fulfill()   //expect the expected label
        
        print("for elements \(MaxIndex) test took \(Date().timeIntervalSince(dts)) seconds")
        
        //wait for 10 seconds
        waitForExpectations(timeout: 5) { (error) in
            XCTAssertNil(error, "Test Expectation failed")
        }
    }
    
}
