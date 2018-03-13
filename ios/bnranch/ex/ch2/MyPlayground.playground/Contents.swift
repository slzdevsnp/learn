//: Playground - noun: a place where people can play

import UIKit


///MARK:- basic types
var str = "Hello, playground"

let constStr = str

//consStr = "baby" // compile error

//numerics
var i : Int  = -1
var f : Float = 10.99
var d : Double = 3.14562

//collections
var arrOfInts : Array<Int>
var arrayOfInts : [Int] // with bracket operator def

var dictOfCapitalByCountry : Dictionary<String,String>.Element

var winLotteryNums : Set<Int>

//assign with literals 
let counting = ["one", "two", "three"]
let nameByParkingLot = [ 13: "Alice", 27: "Bob"] //dictionary with literal

//access by index
print("2nd el: \(counting[1])")

// instantiate with initilizers

var emptyArrOfInts  = [Int]()

let number = 42
let meaningOfLife = String(number) //instantiation with casting 

let availableRooms = Set([205,411,412])

let easyPi = 3.14 //defaults to double 
let flPi = Float(easyPi) // converts to float   or 
let floPi: Float = 3.14

///MARK:- properties & methods
let emptyString = String()
emptyString.isEmpty // isEmpty is String's property 

emptyArrOfInts.append(-11) // instance method
emptyArrOfInts.append(-10) // instance method
emptyArrOfInts.count // a properti 

///MARK:- OPTIONALS 

var  optFl: Float?
var  optArrStr: [String]?
var optArrOPtStr: [String?]?

//assigning value to an optional
optFl = 10.99
optFl = nil  // reassign to nil 

var  fl : Float = 10
//fl = nil // cannot assign nil to a non optional

var r1 : Float?
var r2: Float?
var r3 : Float?
r1 = 9.8 // assigning values to optionals
r2 = 9.2

// let avgr = (r1 + r2) / 2  // compile error because unwraped 
//let avgr = (r1! + r2! + r3!) / 3 // forced unwrap (we must be sure a variables is not nill
                                   // hear compile error because r3 is nil 
// a safe unwrapping way
if let  sr1 = r1, let sr2 = r2 {
     let avgr = (sr1 + sr2) / 2 //this branch will be chosen
    print("avrg of two \(avgr)")
}else if let sr1 = r1, let sr2 = r2, let sr3 = r3{
     let avgr = (sr1+sr2+sr3) / 3
    print("avrg of three \(avgr)")
}else{
    let errStr = "one of the values is nill"
    print("\(errStr)")
}


let nameByPrkingLot = [ 13: "Alice", 27: "Bob", 31:"Jane"] //dictionary with literal

let lot13Assignee: String? = nameByPrkingLot[13] // Alice 
if let clot = nameByPrkingLot[42]{  //this equality check will produce nil
    print("lot 42 is assigned to \(clot)")
}else{
    print("lot 42 is unassigned")
}

///MARK:- loops 

let range = 0..<counting.count
for i in range{
    print("cur counted element: \(counting[i])")
}

//use tuples to assmble keys and values in dictionaries 
for (space, name) in nameByPrkingLot {
    let permit = "Space \(space): \(name)"
    print(permit)
}

///MARK:- Enumerations and Switch statement

enum PieType{
    case apple
    case cherry
    case pecan
}

enum StrategyType{
    case longONly, longShort, systematic, macro //shorter notation
}

let myPie = PieType.cherry

let name:String
switch myPie {
    case .apple:
        name = "Apple"
    case .cherry:
        name = "Cherry"
    case .pecan:
        name = "Pecan"
    default:
        name = "Unknown"
}
print("pie name:\(name)")

enum PieTypeWr: Int{
    case apple = 0  //specify starting index
    case cherry
    case pecan
}

print("pecan raw value: \(PieTypeWr.pecan.rawValue)")

let nPie = PieTypeWr(rawValue: 1) //cherry
let nnPie = PieTypeWr(rawValue: 10) //nil because no raw value 10


