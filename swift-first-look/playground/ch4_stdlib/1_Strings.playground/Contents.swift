//: Playground - noun: a place where people can play

import UIKit

var greeting = "Hello, playground"
var nothing = ""

greeting.isEmpty
nothing.isEmpty

greeting.hasPrefix("Hello")
greeting.hasPrefix("Banana")

nothing.hasPrefix("Hello")
nothing.hasPrefix("")

greeting.hasSuffix("ground")
greeting.hasSuffix("Ground")

nothing.hasSuffix("Ground")
nothing.hasSuffix("")

// MARK: - toInt()

var answer = "42"
Int(answer)
Int(greeting)


    // MARK: - Concatenation

let name = "Alex" + " " + "Vollmer"
let a: Character = "A"
let l: Character = "l"

 // cannot concatenate a Character adnd a "String
//let alex = a + "lex"



var fullName = "Alex Vollmer"
fullName += " .Esq"


// MARK: - Equality check
var same = fullName == name
same = name == "Alex Vollmer"
same = name != "Alex Vollmer"

"alpha" < "bravo"
"bravo" < "alpha"
!("alpha" < "bravo")

"alpha" > "bravo"

// MARK: - Bridging to NSString

// "/Users/alex/Desktop".componentsSeparatedByString("/")  // swift 3

let mutable = NSMutableString(string: "hello")
mutable.append(" There!")
print(mutable)

let ss = "bonzai"
//ss.append(" Road") //# fails as ss is unmutable


let empts = ""
empts.isEmpty


var phrases = "ABCED\nKJMLN\n"
print(phrases)

let replaced = phrases.replacingOccurrences(of: "KJMLN"+"\n", with: "")
print(replaced)

print(String(format:"%@\n",arguments:["mama"]))
print("toto")


var words





