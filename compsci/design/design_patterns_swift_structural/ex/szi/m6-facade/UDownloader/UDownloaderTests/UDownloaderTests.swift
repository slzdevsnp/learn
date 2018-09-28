//
//  UDownloaderTests.swift
//  UDownloaderTests
//
//  Created by Sviatoslav Zimine on 9/25/17.
//  Copyright © 2017 sviatoslav.zimin. All rights reserved.
//

import XCTest
@testable import UDownloader


class UDownloaderTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDownloadToFile() {
        let expect = expectation(description: "Download should succeed")
        
        guard let documentsDirPath = try?  FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)  else {
            XCTFail("Could not find Documents dir path")
            return
        }
        
        let localUrl = documentsDirPath.appendingPathComponent("image.png")
        
        if let url = URL(string: "https://devimages.apple.com.edgekey.net/assets/elements/icons/swift/swift-64x64.png"){
            //a simple 1 method call to achiee a complex async busyness functionality
            // the complexity is hidden
            Downloader.download(from: url, to: localUrl,
                                completionHandler: { (response, error) in
                                    XCTAssertNil(error, "Unexpected error occured:, \(error?.localizedDescription)")
                                    expect.fulfill()
            })
        }
        
        waitForExpectations(timeout: 5) { (error) in
            XCTAssertNil(error, "Test timed out. \(error?.localizedDescription)")
        }
    }
    
    
}
