//
//  Regex.swift
//  CustomizationDemo
//
//  Created by Sviatoslav Zimine on 3/12/17.
//  Copyright © 2017 roga_kopyta. All rights reserved.
//

import Foundation


//--------------------------------------------------
public class Regex : StringLiteralConvertible {
    
    private let pattern:String
    private let expression: NSRegularExpression
    private let noOptions = NSRegularExpressionOptions(rawValue:0)
   
    
    public required convenience init(
        stringLiteral v: StringLiteralType){
        try! self.init(v)
    }
    public required convenience init(
        extendedGraphemeClusterLiteral v: String){
        try! self.init(v)
    }
    public required convenience init(
        unicodeScalarLiteral v: String){
        try! self.init(v)
    }
    
    public init (_ pattern: String) throws {
        self.pattern = pattern
        try! expression = NSRegularExpression(pattern:pattern, options:noOptions)
    }
    
    
    public func matches(input:String) -> Bool{
        let result = expression.matchesInString (
    								input,
    								options: 	NSMatchingOptions(rawValue:0),
    								range: 		NSMakeRange(0, input.count)
        )
        return result.count > 0
    }

    
}
//-----------use Regex in switches ----------------------
public func ~= (inCase: Regex, inSwitch:String) -> Bool {
    return inCase.matches(inSwitch)
}
//----Tilda new operator to create new instance of Regex----
prefix operator ~ {}
public prefix func ~ (operand:String) ->Regex{
    do { return try Regex(operand) }
    catch{
        preconditionFailure("Malformed expression: \(operand)")
    }
}
//------------- infix opertaor -------------------
infix operator ~ {associativity left precedence 130}
infix operator !~ {associativity left precedence 130}

public func ~ (lhs:Regex, rhs:String) -> Bool{
    return lhs ~= rhs
}
public func ~ (lhs:String, rhs:Regex) -> Bool{
    return rhs ~= lhs
}

public func !~ (lhs:Regex, rhs:String) -> Bool{
    return !(lhs ~= rhs)
}
public func !~ (lhs:String, rhs:Regex) -> Bool{
    return !(rhs ~= lhs)
}

//--------------------------------------------------
extension Regex: CustomStringConvertible,
CustomDebugStringConvertible {
    
   	public var description: String {return pattern}
   	public var  debugDescription: String { return pattern}
}

