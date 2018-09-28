//
//  RegexTest.swift
//  CustomizationDemo
//
//  Copyright © 2017 roga_kopyta. All rights reserved.
//

import Foundation

func testRegex(){
    let letters = "[a-z]+"
    let isALetter = try! Regex(letters)
    
    assert(isALetter.matches("abcdef") )
    assert(!isALetter.matches("000"))
    
    assert ( "\(isALetter)" == letters )
    
    let isANumber:Regex = "[0-9]+"
    
    assert( isANumber.matches("012") )
    
    print("testRegex(): pass")
    
    let maPtrn:Regex = "[ma]+"
    assert( maPtrn.matches("mama"))
    
    assert (switchTest("012") == MatchingType.NUM )
    assert (switchTest("abc") == .LET )
    assert (switchTest("*!@") == .OTHER )

    //same with Tilda new operator
    assert (switchTestTilda("012") == MatchingType.NUM )
    assert (switchTestTilda("abc") == .LET )
    assert (switchTestTilda("*!@") == .OTHER )

    
    assert ( isALetter ~ "abcdef"  )
    assert ( "abcdef"  ~ isALetter )
    assert ( isALetter !~ "012" )
    assert ( "012"     !~ isALetter)
    assert ( "abcdef"   ~ ~"[a-z]+" )
    

    
}

enum MatchingType{
    case NUM,LET,OTHER
}

func switchTest( template:String) -> MatchingType{
    switch template {
    case try! Regex("[0-9]+") :  return .NUM
    case try! Regex("[a-z]+") :  return .LET
    default					  :  return .OTHER
    }
}
func switchTestTilda( template:String) -> MatchingType{
    switch template {
    case ~"[0-9]+" :  return .NUM
    case ~"[a-z]+" :  return .LET
    default					  :  return .OTHER
    }
}
