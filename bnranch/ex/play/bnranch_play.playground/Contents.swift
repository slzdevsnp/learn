//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

print("\(str)")

let s = "1.34"
let s1 = "??"
let dbl = Double(s)
let dbl1 = Double(s1)

let i1:Int?
let i2:Int?

i1 = 10
i2 = 20

if let a = i1 , let b = i2 {
    print ("ok")
}


let i = 10;

let ist = String(i)

print("ist: \(ist)")

//MARK: - enums with values


enum OvenState {
    case on(Double)
    case off(String)
}

///uncomment each version 
//let ovenState = OvenState.on(350)
let ovenState = OvenState.off("switched offf")

switch ovenState {
    case let .on(temperature):
        print("oven is on and its temp: \(temperature)")
    case let .off(label):
        print("oven is off and its label \(label)")
}
