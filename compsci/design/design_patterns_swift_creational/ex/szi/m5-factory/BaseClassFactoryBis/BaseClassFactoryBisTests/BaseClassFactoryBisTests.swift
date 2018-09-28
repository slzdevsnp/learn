//
//  BaseClassFactoryBisTests.swift
//  BaseClassFactoryBisTests
//
//  Created by Sviatoslav Zimine on 9/24/17.
//  Copyright © 2017 sviatoslav.zimin. All rights reserved.
//

import XCTest
@testable import BaseClassFactoryBis

class BaseClassFactoryBisTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        
        let label = UILabel(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 600, height: 44)))
        label.textAlignment = .center
        
        //with this palette creation details of implementation  are hidden
        let whiteboardPalette = ColorPalette.make(theme: .whiteboard)
        label.backgroundColor = whiteboardPalette.backgroundColor
        label.textColor = whiteboardPalette.textColor
        label.text = "Whiteboard Palette"
        
        let nightPalette = ColorPalette.make(theme: .nightSwimming)
        label.backgroundColor = nightPalette.backgroundColor
        label.textColor = nightPalette.textColor
        label.text = "Whiteboard Palette"
        
        XCTAssertEqual(whiteboardPalette.backgroundColor, UIColor.white, "whiteboard background not white")

        XCTAssertEqual(nightPalette.backgroundColor, UIColor(hex: 0x191970), "bluenight palette background not bluenight")

    }
    
    /*
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
  */
    
}
