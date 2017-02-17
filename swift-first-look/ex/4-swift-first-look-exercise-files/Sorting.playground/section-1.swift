// Playground - noun: a place where people can play

import UIKit

// MARK: - Declarations

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

// MARK: - Sorting via Comparable

// manipulates element order in-place, so we pass the address (inout)
// to avoid the normal copying behavior of value types
sort(&guitarists)
guitarists

guitarists = guitarists.reverse()
var sortedGuitarists = sorted(guitarists)
sortedGuitarists
guitarists

// MARK: - Sorting with Closures

// manipulates element order in-place, so we pass the address (inout)
// to avoid the normal copying behavior of value types
sort(&guitarists) { $0.firstName < $1.firstName }
guitarists

guitarists = guitarists.reverse()
sortedGuitarists = sorted(guitarists) { $0.firstName < $1.lastName }
guitarists
sortedGuitarists
