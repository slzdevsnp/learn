//: Playground - noun: a place where people can play

import Foundation

///MARK:  - basic looping and if

let list  = [0,1,2,3,4]
//iterate with for

for el in list {
    print("element: \(el)")
}

// accessing list uppper boundary
for i in 0 ..< list.count {
    print("element: \(list[i])")
}
//c++ style (will be deprecated in future versions of swift
for var i = 0; i < list.count; ++i {
    print("element: \(list[i])")
}

//with tuples
let airports = ["SFO":"San Francisco", "LHR":"London"]

for (code,place) in airports {
    print("\(code) in \(place)")
}

//repeat {
//    /*..*/
//} while condition

//if condition{
//    /*..*/
//} else if condition {
//    /*..*/
//} else {
// /*..*/
//}

//whileLabel : while somecondition{
//    if otherCondition {continue whileLabel }
//    if someOtherCondition { break  whileLabel }
//}


///MARK: - switches

//basic example

let someItem: Character = "e"

switch someItem {
    case "a": print ("vowel")
    default: print("consonant")
}

switch someItem {
case "a", "e", "i", "o", "u": print ("vowel")
case "a" ... "z": fallthrough //fallthrough keyword
default: print("consonant")
}


//switch with string
let  sItem = "wildebeest"

switch sItem{
    case "aardvark"..."antelope": print ("a")
    case "baboon"..."bushbuck":  print("b")
    case "caiman"..."curlew":    print("c")
    default: print ("some other animal")
 
}

//switch with tuple
let aPoint = (x:1.0, y:2.0) //tuple

switch aPoint{
    case (let x, 2.0):  print("\(x)") // gets the first true condition
    case (1.0, let y):  print("\(y)")
    case let(x,y) where x>0.0 && y > 0.0: print ("positive \(x), \(y)")
    default:   print ("\(aPoint.x), \(aPoint.y)")
}

//let rgbaColor = (r:1.0, g:1.0, b:1.0, a:1.0) //white option
let rgbaColor = (r:0.0, g:0.51, b:0.95, a:0.99) //blue option

switch rgbaColor {
    case (1.0, 1.0, 1.0, 1.0): print ("white")
    case let(r,g,b,1.0) where r==g && g==b: print("gray")
    case (0.0, 0.5...1.0, let b, _): print("blue is \(b)")
    default: break
}

//switch with enum 

enum Status {
    case Okay(status:Int)
    case Error(code:Int, message:String)
    case NA
}

//let myStatus = Status.Okay(status: 0)
let myStatus = Status.Error(code: -1, message: "weird error message") //option for .Error

switch myStatus{
case .NA: print("na")
case .Okay(0):  print("exit code zero")
case .Error(0, _): print("erorr with code 0 with any message")
case .Error(1..<100, _): print("error with codes 0 - 99 with whatever message")
case .Error(let code, let msg): print("ERROR \(code): \(msg)")  //covers all .Error values
default: break
}

//switch with opptional (explains an optional)

enum anOptional {
        case None
    case Some( value:Int)
    
    mutating func setNil(){
            self = None
    }
    mutating func setValue(value:Int) {self = Some(value:value) }
    
    func getValue() -> Int {
        switch self {
        case .None: fatalError("Nil optional")
        case .Some(let value): return value
        }
    }
    
}

var opt: anOptional = anOptional.Some(value:10)

switch opt{
    case .Some(let val): print("value stored \(val)")
    case .None:              print("value is nil")
}

//with actual optional
var optt: Int? = 10

switch optt {
    case let val?   where val > 0:  print("optt val \(val)")  //with additiona filter
    case nil:                          print("nil value")
    default: break
}

//use of case
var arrayOfOptioanals:[Int?] = [1, nil, 3, nil, 4]
for case let n? in arrayOfOptioanals where n < 4 {  //with case where filter can be applied
    print(n)
}

