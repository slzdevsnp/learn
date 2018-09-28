// Playground - noun: a place where people can play

import UIKit

class Person {
    // Property observers here use default 'newValue' and 'oldValue' symbols
    var firstName: String {
        willSet {
            println("Changing firstName from \(firstName) to \(newValue)")
        }
        
        didSet {
            println("firstName updated from \(oldValue) to \(firstName)")
        }
    }
    
    // Property observers here use custom new- and old-value symbols
    var lastName: String {
        willSet(newLast) {
            println("Changing lastName from \(lastName) to \(newLast)")
        }
        
        didSet(oldLast) {
            println("Changed lastName from \(oldLast) to \(lastName)")
        }
    }
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
}

let p = Person(firstName: "William", lastName: "Shakespeare")
p.firstName = "Bill"
p.lastName = "Cody"