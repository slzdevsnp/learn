//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//MARK: - Array 
// Array is a struct, not a value type

var ar0:[Character] = []
var ar1 = [Int]()

ar1.append(1)
ar1.append(2)
print(ar1)
//ar1.append(3).append(4) // does not work

ar0 = Array("hey".characters)

var ar2:Any = []
ar2 = [1, "hello"] // mixed bag

print("###array casting and type testing")
let art : [Int?] = [1,2,3]
print(art)
for i in 0...art.count - 1  {
    print(art[i]!)
}

class Dog{
    func bark(){print("waf")}
}
class NoisyDog : Dog {
    override func bark(){print("WAF")}
}
let dog1: Dog = NoisyDog()
let dog2: Dog = NoisyDog()
let dog3: Dog = Dog()

let darr = [dog1, dog2, dog3]

//let darrb = darr as [NoisyDog] // fails downcasting  Dog to NoisyDog
let darrb = darr as [Dog] // fails downcasting  Dog to NoisyDog

for i in 0...darrb.count - 1 {
    let d = darr[i]
    d.bark()
}

print("## array numeration and transformations")
let pepboys = ["Manny", "Moe", "Jack"]
for pepboy in pepboys {
    print(pepboy) // prints Manny, then Moe, then Jack
}
print("array enumeration swiftier version")
pepboys.forEach {print($0)}

let ari1 = [[1,2], [4,3], [6,5]]
let ari2 = Array(ari1.joined())
let ari3 = ari2.sorted{$0 > $1} //sort in desc order,  sorted() in usual ascend order
print(ari3)

print ("## filtering array")
let ari4 = ari2.split { $0 % 2 == 0} // filtering an array
ari4.joined().forEach{print($0) } // flatten than print
let pepboys2 = pepboys.filter{$0.hasPrefix("M")}
pepboys2.forEach{print($0)}

print("### map transformation")
let ari5 = [1,2,3]
let ari6 = ari5.map{$0 * $0 }
print(ari6)
let ari7 = ari5.map{Double($0)} // casting
print(ari7)

//for UITable 
//let path0 = indexPath(row:0, section:sec) for section sec
//let paths = (0..<ct).map {IndexPath(row:$0, section:sec)}

print("## flatmap transforms")
let ard1 = [[1,2],[3,4]]
//let ard2 = ard1.flatMap{$0} // just a flatmap same as join

// flatten and transform to String
let ard2 = ard1.flatMap{$0.map{String($0)}}

print(ard2)

let ara : [Any] = [1, "hey", 2, "ho"]
let ara1 = ara.flatMap{$0 as? String}
//compare with   let ara1 = ara.map{$0 as? String}
print(ara1)

print("### summing all elements of vector")
let ari10 = [1,2,3]
let sum1 = ari10.reduce(0){$0 + $1}
print(sum1)

let ars1 = ["one", "two", "three"]
print(ars1.reduce(""){$0 + $1}   )

print("## complex filtering example")
let arrd = [["Manny", "Moe", "Jack"],
            ["Harpo", "Chico", "Groucho", "Norman"] ]

let target = "m"

let arrt = arrd.map{
        $0.filter {
            let found = $0.range(of:target, options:.caseInsensitive)
            return (found != nil)
        }
    }.filter {$0.count > 0 } // try $0.count > 1

print(arrt)

print("####### Dictionary #########")
//Dictionary is a struct and unordered collection with key - value pairs
// keys usually strings, but they do not have to be
// keys bust be Equatable and Hashable  adopting those protocols

var d0 = [String:String]()
d0["CA"] = "California"
d0["NY"] = "New York"
print(d0["CA"]) // as you see the value is an optional of the string
var d1 = ["CA": "California", "NY":"New York"]
print(d1["CA"]!)

//d1["CA"] = "Casablanca" //reassinging
let oldv = d1.updateValue("Casablanca", forKey: "CA")
d1["MD"] = "Mariland" // adding
d1.forEach{print($0)}
print(oldv!) // oldvalue was stored in a sepaprate variable

d1["NY"] = nil  //removing a pair

d1["AL"] = "Alaska"
d1.forEach{print($0)}

let dog11 : Dog = NoisyDog()
let dog12 : Dog = NoisyDog()


let dd = ["fido" : dog11, "rover" : dog12]
dd.forEach{print($0)}

let dd2 = dd as! [String : NoisyDog] // casting down
dd2.forEach{print($0)}

print("dict enumeration")
for k in d1.keys {
    print(k) // key
    print(d1[k]!) // value
}

var keys = Array(d1.keys)

//enum with key-value tuple
for (abbrev, state) in d1 {
    print("\(abbrev) stands for \(state)")
}

print("--dictionary with sorted keys")
for ks in d1.keys.sorted() {
    print("\(ks) is for \(d1[ks]!)")
}

//filtering transformations apply to dicts

let dage = ["mike":10,"ivan's":3, "nico":11, "bob":5 ]
let fltage = dage.values.filter{$0 > 4 }
print(Array(fltage))
