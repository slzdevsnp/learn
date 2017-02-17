// Playground - noun: a place where people can play

import UIKit

// MARK: - People

class Person {
    var firstName: String
    var lastName: String
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    // Convenience initializer sets name to "John" and "Doe"
    // Subclasses CANNOT use this method in their own initializers
    convenience init() {
        // Can't directly assign default values here. We MUST call a
        // designated initializer first
        self.init(firstName: "John", lastName: "Doe")
    }
    
    // Designated initializer sets name to "John" and "Doe". 
    // Subclasses can use this method in their own initializers
//    init() {
//        self.firstName = "John"
//        self.lastName = "Doe"
//    }
}

let p1 = Person(firstName: "Bob", lastName: "Smith")
let p2 = Person()

// MARK: - Students

class Student: Person {
    let age: Int
    
    var description: String {
        get {
            return "Student: \(firstName) \(lastName) is \(age)"
        }
    }
    
    init(firstName: String, lastName: String, age: Int) {
        self.age = age
        super.init(firstName: firstName, lastName: lastName)
    }
    
    convenience init(age: Int) {
        self.init(firstName: "John", lastName: "Doe", age: age)
    }

    // Can't do this since a sub-class initializer MUST call a designated
    // initializer on the super-class UNLESS the Person.init() is defined
    // as a designated initializer
//    init(age: Int) {
//        self.age = age
//        super.init()
//    }
}

let chuck = Student(firstName: "Charlie", lastName: "Brown", age: 12)
let john = Student(age: 13)

// MARK: - Employees

class Employee: Person {
    // With a default value for this property, the Employee class automatically
    // gets an inherited initializer
    var yearsOfService = 0
    
    // By designating this initializer as a convenience initializer, we still
    // automatically inherit the init(String, String) initializer from 
    // the superclass.
    convenience init(firstName: String, lastName: String, yearsOfService: Int) {
        // We MUST call self.init(...) before assigning any properties
        // because we're a convenience initializer
        self.init(firstName: firstName, lastName: lastName)
        self.yearsOfService = yearsOfService
    }
}

let e1 = Employee()
let e2 = Employee(firstName: "Walter", lastName: "Mitty", yearsOfService: 20)
let e3 = Employee(firstName: "Sally", lastName: "Johnson")


