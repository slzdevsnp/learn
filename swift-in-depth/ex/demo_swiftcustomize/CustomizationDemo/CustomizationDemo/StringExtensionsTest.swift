
//  StringExtensionsTest.swift
//  Copyright © 2017 roga_kopyta. All rights reserved.
//

import Foundation

//----------------------------------------
func testStringExtensions() {
    let fred = "fred"
    
    assert ( fred.count == fred.characters.count )
    
    
    //test IntegerLiteralConvertible
    let number:String = 1234
    assert ( number == "1234")

    //test sring as an array
    var s = "0123456789"

    assert(s[2] == "2")
    assert(s[1...3] == "123")
    
    //test reassignement of a string
    s[1] = "a"
    s[2] = "b"
    s[3] = "c"
    s[7...9] = "XYZ"
    assert ( s == "0abc456XYZ")

    print("testStringExtensions() : pass")
}
