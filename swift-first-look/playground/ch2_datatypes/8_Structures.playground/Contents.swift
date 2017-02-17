//: Playground - noun: a place where people can play

import UIKit

class Person {
    var firstName: String // do not use let to modify the field
    var lastName: String
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
}

struct Dude{
    var firstName: String
    var lastName: String
}

let p1 = Person(firstName: "Alex", lastName: "Vollmer")
let p2 = p1

print("p1 \(p1.firstName) \(p1.lastName) and p2 \(p2.firstName) \(p2.lastName)")
p1.firstName = "William"
p1.lastName = "Shakespeare"
print("p1 \(p1.firstName) \(p1.lastName) and p2 \(p2.firstName) \(p2.lastName)")

var d1 = Dude(firstName: "Michael", lastName: "Jordan")
var d2 = d1

d1.firstName = "John"
d1.firstName = "Lennon"
//d1 and d2 are separate copies
print("d1 \(d1.firstName) \(d1.lastName) and d2 \(d2.firstName) \(d2.lastName)")





