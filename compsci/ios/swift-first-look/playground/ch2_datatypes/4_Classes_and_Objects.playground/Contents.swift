//: Playground - noun: a place where people can play

import UIKit

class Person {
    var firstName: String
    var lastName: String
    
    init(firstName: String, lastName: String){
        self.firstName = firstName
        self.lastName  = lastName
    }
    
    func say(phrase: String){
        print("\(firstName) \(lastName) says \(phrase)")
    }
    //class method
    class func say(phrase: String){
        print(".. and all the people say \(phrase)")
    }
}

let p1 = Person(firstName: "Michael", lastName:"Normann")
p1.say(phrase:"let's write some swift")

Person.say(phrase: "let's get some tacos")

