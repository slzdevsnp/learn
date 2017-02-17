//: Playground - noun: a place where people can play

import UIKit

let cardsInDeck = 52
var players = 4


class Person {
    let firstName: String
    let lastName: String
    //initializer
    init(firstName: String, lastName:String){
        self.firstName = firstName
        self.lastName = lastName
    }
}

//create an instance of a class immutable
let me = Person(firstName: "Slava", lastName: "Zimine")

//arrays

var mutable = ["alpha", "bravo", "gamma"]
let immutable = ["alpha", "bravo", "gamma"]
// immutable.append("zorro") //cannot change an immutable type



