// Playground - noun: a place where people can play

import UIKit

class Person {
    let firstName: String
    let lastName: String
    var age: Int = 0 {
        willSet {
            println("\(fullName) age will be set to \(newValue)")
        }
    }

    var fullName: String {
        get {
            return "\(firstName) \(lastName)"
        }
    }
    
    deinit {
        println("\(fullName) is going away")
    }
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }

    // Marking this method as 'final' prevents overrides
//    final func say(phrase: String) {
    func say(phrase: String) {
        println("\(fullName) says '\(phrase)'")
    }
}

class Student: Person {
    // You can't override stored properties
//    override let firstName: String = "Student"
//    override let lastName: String = "Person"
    
    override var age: Int {
        willSet {
            println("Student's age will be set to \(newValue)")
        }
    }
    
    // "override" keyword is required here
    override var fullName: String {
        get {
            return super.fullName.uppercaseString
        }
    }
    
    deinit {
        println("\(fullName) is going away")
    }
    
    // 'override' keyword is required here
    // If the Person.say method is marked as final
    // this method cannot be overridden
    override func say(phrase: String) {
        println("Student \(fullName) politely says: '\(phrase)'")
    }
}

var p = Person(firstName: "Alex", lastName: "Vollmer")
var s = Student(firstName: "Ferris", lastName: "Bueller")

p.fullName
s.fullName

p.say("Howdy!")
s.say("Hello there")

p.age = 30
s.age = 16
