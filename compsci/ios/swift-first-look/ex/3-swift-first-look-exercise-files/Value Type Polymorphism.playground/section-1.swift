// Playground - noun: a place where people can play

import UIKit

// We can't prefix this with @objc if we want structures or enumerations
// to declare support for it
//@objc protocol Named {
protocol Named {
    var name: String { get }
}

//class Thing: Named {
//    var name: String { return "Thing" }
//}
//let t = Thing()

struct Person: Named {
    var name: String { return "John Doe" }
}
let p = Person()
p.name

enum Suit: String, Named {
    case Hearts = "♡"
    case Diamonds = "♢"
    case Clubs = "♧"
    case Spades = "♤"
    
    var name: String { return self.toRaw() }
}

let hearts = Suit.Hearts
hearts.name
let spades = Suit.Spades
spades.name

let namedThings: [Named] = [hearts, spades, p]
println(namedThings.map() { $0.name })

let things: [Any] = [hearts, spades, p, false, "banana"]
for thing in things {
    println("thing is \(thing)")
    // the check for 'Named' won't work without @objc prefix
    if thing is Named {
        println("Yep")
    }
    else {
        println("Nope")
    }
}
