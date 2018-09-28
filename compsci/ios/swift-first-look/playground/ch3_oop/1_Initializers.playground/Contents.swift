//: Playground - noun: a place where people can play

import UIKit

class Person {
    // With these property declarations the init(String, String) method MUST
    // be implemented since our constants MUST have a value
    let firstName: String
    let lastName: String
    
    // ## a way to assign a default values  and no need for initilizer for the compiler
    //    let firstName: String = "John"
    //    let lastName: String = "Doe"
    
    // ## a way to declare optionals without a default value
    //    let firstName: String?
    //    let lastName: String?
    
    
    //  ## A designated initializer to keep the compiler happy for
    // non-optional properties without default values
    // init(firstName: String, lastName: String) {
    //     self.firstName = firstName
    //     self.lastName = lastName
    // }
    
  
    
    // ## a desingnated initializer Default values can be specified in the initializer which effectively
    // replaces the no-arg init method
        init(firstName: String = "John", lastName: String = "Doe") {
            self.firstName = firstName
            self.lastName = lastName
        }

    
    
    // ## A convenience initializer with default properties values.
    // This isn't needed if the properties are declared above with
    // default values or as optionals
    convenience init() {
        self.init(firstName: "John", lastName: "Doe")
    }
    
    // Another designated initializer setting default properties directly.
    // This isn't needed if the properties are declared above with
    // default values or as optionals
    //    init() {
    //        self.firstName = "John"
    //        self.lastName = "Doe"
    //    }

  }

let p = Person()
let pp = Person(firstName: "Alex", lastName: "Vollmer")
let ppp = Person(firstName: "Lina")

