// Playground - noun: a place where people can play

import UIKit

// Variations matrix:
// - optional vs. non-optional
// - default values in declaration (or not)
// - dealing with the superclass
// - var vs. let properties

class Person {
    // With these property declarations the init(String, String) method MUST
    // be implemented since our constants MUST have a value
    let firstName: String
    let lastName: String

    // With these property declarations we don't need to define an initializer.
    // The default no-arg one is provided for us. If we do provide the
    // init(String, String) initializer, it can specify different values
    // for the properties
//    let firstName: String = "John"
//    let lastName: String = "Doe"

    // With these property declarations we can rely on just the default
    // no-arg initializer
//    let firstName: String?
//    let lastName: String?

    // With these property declarations we can rely on just the default
    // no-arg initializer
//    let firstName: String!
//    let lastName: String!

    // A designated initializer to keep the compiler happy for
    // non-optional properties without default values
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    // Another designated initializer setting default properties directly.
    // This isn't needed if the properties are declared above with
    // default values or as optionals
//    init() {
//        self.firstName = "John"
//        self.lastName = "Doe"
//    }
    
    // A convenience initializer with default properties values.
    // This isn't needed if the properties are declared above with 
    // default values or as optionals
    convenience init() {
        self.init(firstName: "John", lastName: "Doe")
    }

    // Default values can be specified in the initializer which effectively
    // replaces the no-arg init method
//    init(firstName: String = "John", lastName: String = "Doe") {
//        self.firstName = firstName
//        self.lastName = lastName
//    }
}

let p = Person()
let av = Person(firstName: "Alex", lastName: "Vollmer")
