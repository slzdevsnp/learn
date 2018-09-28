//: Playground - noun: a place where people can play

import Foundation

let someString = "hello"
let someStringBis = "0010"

var possibleNum: Int?  //might not be a legit value in it  optional

possibleNum = Int(someString) // no compile error or runtime error
possibleNum = Int(someStringBis) // valid conversion here

//let x = possibleNum!  // varname! means actual value in that variable , inalid here os  runtime error
let x = possibleNum

if possibleNum != nil {
    let theNum = possibleNum!
}

// a safe way to use  a var which can be nill is
if let a = possibleNum { // if possibleNum is nillhere that no code excution betweeen braces
    print("\(a)")
}


//if let syntax can have maltiple statments on 1 line  i.e.

func cow() -> Int? {/*..*/ return(0)}
func bar() -> Int? {/*..*/ return(0)}

var optionalValue : Int?

optionalValue = 10

if let a = optionalValue, b = bar() where a < b, let c = cow(){
    /*  safe usage of c inside brakets */
}

