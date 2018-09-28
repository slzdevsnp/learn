//: Playground - noun: a place where people can play

import UIKit


class Person{
    
    var firstName: String{
        willSet {
            print("changing firstname from \(firstName) to \(newValue)")
        }
        didSet {
            print("firstName updated from \(oldValue) to \(firstName) ")
        }
    }
    
    var lastName: String{
        willSet(newLast){
            print("changing lastName from \(lastName) to \(newLast)")
        }
        didSet(oldLast){
            print("changed lastName from \(oldLast) to \(lastName)")
        }
    }
    
    init(){
        self.firstName = "Joe"
        self.lastName = "Doh"
    }
    init(firstName: String, lastName: String){
        self.firstName = firstName
        self.lastName = lastName
    }
}



let p = Person(firstName: "Ben", lastName: "Fouler")
p.firstName = "Bill"
p.lastName = "Cody"




