//: Playground - noun: a place where people can play

import UIKit

class Person {
    var firstName: String
    var lastName: String
    
    init(firstName: String, lastName: String){
        self.firstName = firstName
        self.lastName  = lastName
    }
    
    func say(phrase:  String){
        print("\(self.firstName) \(self.lastName) says \(phrase)")
    }
    
    func say(phrase str: String, times: Int) {
        for i in 0...times {
            say(phrase: str)
        }
    }
}

let p = Person(firstName: "Alex", lastName: "Smirnoff")

p.say(phrase: "Hi")
p.say(phrase: "hello", times: 2)

