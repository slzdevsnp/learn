//: Playground - noun: a place where people can play

import Foundation

/// MARK: - operators

var z = 10
var w = 1
//z =-w // swift is picky about white spaces

z = -w

//mod works between floats and ints

123.59 % 123
//and event doubles
123.59 % 123.10

var a: Int = Int.max
var b: Int = 10

//a + b // #produces a hard compile error

a &+ b // does not produce error
a &* b
-a &- b
// a &/ b //# &/ not permitted 

//range operator 
1...3
1..<4

let i = 5
if  1...10  ~= 5 { print("i is in the range \(i)") }

/// MARK: - Declarations

var someVariaable = 10

var otherVariable: Int  // specify type
otherVariable = 10 // separate assignement 

//for const
let someConstant = "123"
//someConstant = "0xxx" //#compile error const reassignement

let anInt = 10
let aDbl = 1.1

//let x = aDbl + anInt // no implicit casting in swift

let x = aDbl + Double(anInt) // explicit casting 


/// MARK: - Strings


var swiftString: String = "abc" // this string is bridged to NSString by the compiler
var objcString: NSString = "def"

objcString = swiftString //works 
//swiftString = objcString // compiler error

swiftString = objcString as String  // casting 


var bird = "chicken"
bird += " run" //concatenation

bird = "road" + " runner"

bird.isEmpty
bird.characters.count // string length 

bird.hasPrefix("roa")
bird.hasSuffix("nner")

bird != swiftString // bolean comparison

bird.utf8
bird.utf16

//walking through String chars 
var s = "0123456789"
Int(s) //convertion that may work 

s[s.startIndex]
s[s.startIndex.successor()]
s[s.endIndex.predecessor()] //last char in string
s[s.startIndex.advancedBy(2)] //3d character 

s.insert("|", atIndex: s.startIndex.advancedBy(3) )





















