//: Playground - noun: a place where people can play

import UIKit

class Person {
    let firstName: String
    let lastName: String
    var age: Int = 0 {
        willSet {
            print("\(fullName) age will be set to \(newValue)")
        }
    }
    
    var fullName: String {
        get {
            return "\(firstName) \(lastName)"
        }
    }
    
    deinit {
        print("\(fullName) is going away")
    }
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    // # final prevents overriding
    func say(phrase: String) {
        print("\(fullName) says '\(phrase)'")
    }
    

}

class Student : Person{
     override var fullName: String{
        get{
            return super.fullName.uppercased()
        }
    }
    
    override func say(phrase: String){
        print("Student \(fullName) politely says \(phrase)")
    }
    
    deinit {
        print("\(fullName) is going away")
    }
    
}

var p = Person(firstName: "Al", lastName: "Gore")
var s = Student(firstName: "Jilles", lastName: "Veyron")

p.fullName
s.fullName

print(p.say(phrase: "Howdy"))
print(s.say(phrase: "Hallo prof"))



