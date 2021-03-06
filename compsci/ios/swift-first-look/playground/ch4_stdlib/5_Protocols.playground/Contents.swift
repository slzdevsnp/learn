//: Playground - noun: a place where people can play

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

//define global functions for Person instances
func == (lhs: Person, rhs: Person) -> Bool{
    return lhs.firstName == rhs.firstName
          && lhs.lastName == rhs.firstName
}

will == liz
will != liz // we defined Extension on Person: Equatable



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
liz > will // we defined exteions on Person : Comparable
liz < Person(firstName: "Henry", lastName: "Tudor")


// MARK: - Printing

// Printable gone in swift3
extension Person {
    var description: String {
        return "Person(\(firstName) \(lastName))"
    }
}

// At the time of the 6.0 release, the Playground doesn't correctly
// invoke the `description` property when using `println()`
print(will)
print(liz)
print(Person(firstName: "Henry", lastName: "Tudor"))



