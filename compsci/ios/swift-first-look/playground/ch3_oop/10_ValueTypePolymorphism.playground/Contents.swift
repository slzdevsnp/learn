//: Playground - noun: a place where people can play

import UIKit

protocol Named {
    var name: String {get}
}


struct Person: Named {

    var name: String {return "John Doe" }
}


enum Suit: String, Named {
    case Hearts = "♡"
    case Diamonds = "♢"
    case Clubs = "♧"
    case Spades = "♤"

    var name: String { return self.rawValue }
}


let p = Person()
p.name


let hearts = Suit.Hearts
hearts.name

let spades = Suit.Spades
let clubs = Suit.Clubs
clubs.name

let  namedThings  = [hearts, spades, clubs, p ] as [Named]

print(namedThings.map(){$0.name} ) //# printing a collection

let Things = [hearts, spades, p, false, "hello"] as [Any]

for thing in Things{
    // in swift 3 this is resolved for value tyopes (struct and enum)
    if thing is Named{ print("yep") }else{ print("nope") }
}


