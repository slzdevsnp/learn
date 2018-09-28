// Playground - noun: a place where people can play

import UIKit

// MARK: - Constant and Variable Basics

let cardsInDeck = 52
// Uncomment this for Swift compiler failure
//cardsInDeck = 48

var players = 5
players = 4  // no problem changing the number of players

// MARK: - Mutability and Immutability

var mutable = ["alpha", "bravo", "charlie"]
mutable.append("delta")

let immutable = ["alpha", "bravo", "charlie"]
// Uncomment this to get the Swift failure message
//immutable.append("delta")

// MARK: - Run-time Constant Assignments

// You can declare a constant without assigning a value at compile-time.
// But once a constant is set, it cannot be changed. In the Person class
// we can declare the `firstName` and `lastName` properties to be constants
// eventhough we don't have values for them at compile-time
class Person {
    let firstName: String
    let lastName: String
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
}

let me = Person(firstName: "Alex", lastName: "Vollmer")
//me = Person(firstName: "Ron", lastName: "Swanson")

// Uncomment these to see Swift compiler failure about attempting to
// modify the value of a Swift constant property
//me.firstName = "Ron"
//me.lastName = "Swanson"

// Even if a Person instance is declared as a variable, you cannot change
// its properties that are constants
var will = Person(firstName: "William", lastName: "Shakespeare")
// Uncomment this line for Swift compiler failure message
//will.lastName = "Tell"

// MARK: - Mutability of Structures

struct Name {
    var first: String
    var last: String
}

let av = Name(first: "Alex", last: "Vollmer")
av.last = "The Great"



