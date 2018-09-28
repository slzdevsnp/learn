// Playground - noun: a place where people can play

import UIKit

enum Suit {
    case Hearts
    case Diamonds
    case Clubs
    case Spades
}

class Doohickey {
}

struct Name {
    let firstName: String
    let lastName: String
}

class Thingie {
    var name: String = "thingie"
    var doohickey = Doohickey()
    var tuple = (code: 404, message: "Not Found")
    var personName = Name(firstName: "Alex", lastName: "Vollmer")
}

let t = Thingie()
t.name
t.doohickey
t.tuple.code
t.personName