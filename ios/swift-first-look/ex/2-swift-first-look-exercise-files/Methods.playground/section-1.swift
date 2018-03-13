// Playground - noun: a place where people can play

import UIKit

// NOTE: Things are different when a function is a
// method in a class. For example the say(String, Int)
// method _REQUIRES_ the parameter name for the
// second argument

class Person {
    var firstName: String = ""
    var lastName: String = ""
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    func say(phrase: String) {
        println("\(self.firstName) \(self.lastName) says: '\(phrase)'")
    }
    
    func say(phrase: String, times: Int) {
        for i in 0...times {
            say(phrase)
        }
    }
}

let p = Person(firstName: "Alex", lastName: "Vollmer")
p.say("Hi")
p.say("Hello", times: 3)
p.say("Howdy!", times: 5)
