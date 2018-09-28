//: Playground - noun: a place where people can play

import Foundation

/// MARK -  Arrays 

var someArray: [String] = ["aa", "bb", "cc"]


var  arr1 = Array<String>()
var  arr2 = [String]()

var repeatedArr = [String](count:3, repeatedValue:"mama")

//bunch of operators on array

someArray.append("dd")
someArray += ["ee", "ff"]  // append 1 or concatenate multiple elements

someArray.insert("gg", atIndex: 6)


someArray.removeAtIndex(6)
someArray
someArray.removeLast()
someArray

//range operator
someArray[1...2] = ["B", "C"] // replacing elements at index 1 to 2
someArray

//2 dimensional arrrays

var twoD: [[String]] = [ ["a", "b", "c"],
                           ["d", "e", "f"] ]

twoD[0] = ["A", "B", "C"]  // replace the whole row
twoD[0][0] = "-A"  //access specific element
twoD



///MARK: - Sets

var myset: Set<String> = ["A", "B", "C", "C"] // only unique elements
var c = Set<String> ( ["A", "B", "C"])
c.insert("F")
if let oldValue = c.remove("A") { c.insert("Z") }  // .remove() returns an optional (can be nil)

c.count
c.contains("Z")
c.removeAll()
c.isEmpty
c.isDisjointWith(myset)
myset.isSupersetOf(c)
myset.isSubsetOf(c)

var a: Set<Int> = [1,2,3,5]
var b: Set<Int> = [5,1,8,9]


a.exclusiveOr(b)
a.intersect(b)
a.union(b)
a.subtract(b)
b.subtract(a)

// inPlace version modifies the  variable at left
let s1 = a.exclusiveOrInPlace(b)
a
let s2 = a.intersectInPlace(b)
a
let s4 = a.unionInPlace(b)
a



/// MARK: - Dictionaries

// a dictionary is a key value pair ( java Map) 

var httpStatus: [Int:String] = [:] //empty dictionary

httpStatus = [200:"OK", 404:"Page Not Found"]

httpStatus [500] = "Internal Error"

if let old = httpStatus.updateValue("PageNotFound", forKey: 404){ //will update if key exists
    print("updated")
}
//iterate
for (code,message) in httpStatus{
    print("\(code): \(message)")
}
httpStatus[404] = nil
httpStatus
if let old = httpStatus.removeValueForKey(404)  { print("removed") }
httpStatus.isEmpty








