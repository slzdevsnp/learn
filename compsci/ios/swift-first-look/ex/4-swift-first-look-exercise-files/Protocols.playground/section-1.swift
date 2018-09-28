// Playground - noun: a place where people can play

import UIKit

class Person {
    let firstName: String
    let lastName: String
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
}

let will = Person(firstName: "William", lastName: "Shakespeare")
let liz = Person(firstName: "Elizabeth", lastName: "Tudor")

// MARK: - Equality

// Declare conformance on the type, but the actual protocol method is
// defined globally *outside* of the type (see below)
extension Person: Equatable {
}

// Global equality function for Person instances
func == (lhs: Person, rhs: Person) -> Bool {
    return lhs.firstName == rhs.firstName && lhs.lastName == rhs.lastName
}

will == liz
will != liz

// MARK: - Comparison

// Declare conformance on the type, but the actual protocol method is
// defined globally *outside* of the type (see below)
extension Person: Comparable {
}

// Global comparison function for Person instances
func <(lhs: Person, rhs: Person) -> Bool {
    if lhs.lastName == rhs.lastName {
        return lhs.firstName < rhs.firstName
    }
    else {
        return lhs.lastName < rhs.lastName
    }
}

will < liz
liz < will
liz < Person(firstName: "Henry", lastName: "Tudor")

// MARK: - Printing

extension Person: Printable {
    var description: String {
        return "Person(\(firstName) \(lastName))"
    }
}

// At the time of the 6.0 release, the Playground doesn't correctly
// invoke the `description` property when using `println()`
println(will)
println(liz)
println(Person(firstName: "Henry", lastName: "Tudor"))
