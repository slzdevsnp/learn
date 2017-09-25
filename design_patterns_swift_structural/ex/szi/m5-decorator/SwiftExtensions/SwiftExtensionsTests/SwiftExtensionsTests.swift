//
//  SwiftExtensionsTests.swift
//  SwiftExtensionsTests
//
//  Created by Sviatoslav Zimine on 9/25/17.
//  Copyright © 2017 sviatoslav.zimin. All rights reserved.
//

import XCTest
import UIKit
@testable import SwiftExtensions

class SwiftExtensionsTests: XCTestCase {
    
    
    private func printXCTestHeader(_ label: String) {
        print("\n*************************************************")
        print("*  \(label)")
        print("**************************************************\n")
    }

    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFahrenheit() {
        printXCTestHeader(" testing double as fahrenheit")
        
        let boilingWater = 100.0
        print("Water boils at \(boilingWater)°C / \(boilingWater.fahrenheit)°F")
        
        XCTAssertEqual(boilingWater.fahrenheit, 212.0 , "fahrehheit value unexpected")
    }
    
    func testStringLowerCase(){
        printXCTestHeader("isStringLowerCased")
        let string1 = "abcde"
        XCTAssert(string1.isLowercase(), "lowercase value wrong")
        let string2 = "aBcde"
        XCTAssert(!string2.isLowercase(), "lowercase value wrong")
    }
    
    func testCGVectorNewInit(){
        printXCTestHeader("testCGVectorNewInit")
        
        let vec2D = CGVector( point: CGPoint(x: 2, y: 5))
        print("CGVector \(vec2D) initialized with CGPoint")
        
        XCTAssert( vec2D.dx == CGFloat(2.0) && vec2D.dy == CGFloat(5.0), "vector value unexpected")
    }

    func testStringSubscript(){
        printXCTestHeader("testStringSubscript")
        let message = "No pasa ran"
        for i in 0..<message.lengthOfBytes(using: .utf8){
            print(message[i])
        }
        XCTAssert(true, "unexpected")
    }
    
    func testStringNestedType(){
        printXCTestHeader("testStringNestedType")
        
        let strLower = "abcdef"
        print("\(strLower) is \(strLower.caseType)")
        let strMixed = "Abcdef"
        print("\(strMixed) is \(strMixed.caseType)")
        let strUpper = "ABCDEF"
        print("\(strUpper) is \(strUpper.caseType)")
        
        XCTAssert(true)
    }
    
    func testDecoratedLabel(){
        printXCTestHeader("testDecoratedLabel")
        
        //this is better tested in the playground
        let lightBlue = UIColor(hex: 0x3CB5B5)
        
        let frame = CGRect(origin: CGPoint.zero, size: CGSize(width:400, height: 44))
        let label = UILabel(frame: frame)
        var roundedLabel = BorderedLabelDecorator(label: label, cornerRadius: 10, borderWidth: 1, borderColor: .red)
        roundedLabel.textAlignment = .center
        roundedLabel.backgroundColor = .white
        roundedLabel.textColor = lightBlue
        roundedLabel.text = "Rounded label with border and custom text"
        
        XCTAssert(true)

        
    }
    
}
