// Playground - noun: a place where people can play

import UIKit

var greeting = "Hello, playground"
var nothing = ""

// MARK: - isEmpty

greeting.isEmpty
nothing.isEmpty
"   ".isEmpty

// MARK: - Prefixes & Suffixes

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
answer.toInt()
greeting.toInt()

// MARK: - Concatenation

let name = "Alex" + " " + "Vollmer"
let a: Character = "A"
let l: Character = "l"

// This doesn't work anymore
//let alex = a + "lex"

// This works because Character + Charcter = String which can be concatenated with another String
//let alex = a + l + "ex"

// This works because you can concatenate a Character and a String
let al = a + l

// Doesn't work since 'name' is a constant
//name += " .Esq"

var fullName = "Alex Vollmer"
fullName += " .Esq"

// MARK: - Equality check

var same = fullName == name
same = name == "Alex Vollmer"
same = name != "Alex Vollmer"

// MARK: - Lexographical Comparison

"alpha" < "bravo"
"bravo" < "alpha"
!("alpha" < "bravo")
//"alpha" > "bravo"

// MARK: - Bridging to NSString

"/Users/alex/Desktop".componentsSeparatedByString("/")

let mutable = NSMutableString(string: "Hello")
mutable.appendString(" There!")
println(mutable)
