//: Playground - noun: a place where people can play

import UIKit

class Person: Comparable, Equatable {
    let firstName: String
    let lastName: String
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
}

// Global equality function for Person instances
func == (lhs: Person, rhs: Person) -> Bool {
    return lhs.firstName == rhs.firstName && lhs.lastName == rhs.lastName
}

// Global comparison function for Person instances
// `Comparable` protocol also requires `Equatable` conformance
func <(lhs: Person, rhs: Person) -> Bool {
    if lhs.lastName == rhs.lastName {
        return lhs.firstName < rhs.firstName
    }
    else {
        return lhs.lastName < rhs.lastName
    }
}


let evh = Person(firstName: "Eddie", lastName: "Van Halen")
let jp = Person(firstName: "Jimmy", lastName: "Page")
let jh = Person(firstName: "Jimi", lastName: "Hendrix")
let sv = Person(firstName: "Steve", lastName: "Vai")


var guitarists = [evh, jp, jh, sv]

// swift 2  sort(&guitarists)
guitarists.sort()
guitarists

guitarists = guitarists.reversed()
guitarists

guitarists.sorted()  // after a reversal. sorted() 


var sortedGuitarists = guitarists.sorted() { $0.firstName < $1.lastName }
sortedGuitarists









