//
//  SessionStateTests.swift
//  SessionStateTests
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
        let asyncQueue = DispatchQueue( label: "asyncQueue", attributes: .concurrent, target: nil )
        
        let expect = expectation(description: "Storing values in SessionState shall succeed")
        
        let MaxIndex = 1000
        
        for index in 0...MaxIndex {
            asyncQueue.async {
                SessionState.shared.set( index, forKey: String(index) )
            }
        }
        
        // wait until the last element is written
        while SessionState.shared.object(forKey: String(MaxIndex)) as? Int != MaxIndex {
            // nop
        }
        
        expect.fulfill()
        
        waitForExpectations(timeout: 10) { (error) in
            XCTAssertNil(error, "Test expectation failed")
        }
    }
}












