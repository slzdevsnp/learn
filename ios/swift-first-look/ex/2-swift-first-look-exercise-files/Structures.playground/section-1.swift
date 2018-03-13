// Playground - noun: a place where people can play

import UIKit

class Person {
    var firstName: String
    var lastName: String
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
}

struct Dude {
    var firstName: String
    var lastName: String
}

let p1 = Person(firstName: "Alex", lastName: "Vollmer")
let p2 = p1

println("p1 is \(p1.firstName) \(p1.lastName), p2 is \(p2.firstName) \(p2.lastName)")

p1.firstName = "William"
p1.lastName = "Shakespeare"
println("p1 is \(p1.firstName) \(p1.lastName), p2 is \(p2.firstName) \(p2.lastName)")

var d1 = Dude(firstName: "Alex", lastName: "Vollmer")
var d2 = d1

println("d1 is \(d1.firstName) \(d1.lastName), d2 is \(d2.firstName) \(d2.lastName)")

d1.firstName = "William"
d1.lastName = "Shakespeare"

println("d1 is \(d1.firstName) \(d1.lastName), d2 is \(d2.firstName) \(d2.lastName)")
