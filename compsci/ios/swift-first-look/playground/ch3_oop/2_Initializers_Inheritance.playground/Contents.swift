//: Playground - noun: a place where people can play

import UIKit

class Person {
    var firstName: String
    var lastName: String
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    // Subclasses CANNOT use this convenience method in their own initializers
     init() {
        self.firstName = "John"
        self.lastName = "Doe"
    }
}

class Student : Person {
        let age: Int
        
        init(firstName: String, lastName: String, age: Int){
            self.age = age
            super.init(firstName: firstName, lastName: lastName)
        }
        
        init(age: Int){
            self.age = age
            super.init()
        }
}


class Employee : Person{
    var yearsOfService = 0
    
      convenience init(firstName: String, lastName: String, yearsOfService: Int) {
        self.init(firstName: firstName, lastName: lastName)
        self.yearsOfService = yearsOfService
    }
}

    let s = Student(firstName: "Ivan", lastName: "Belkin", age: 20)
    let ss = Student(age: 21)

    let e1 = Employee()
    let e2 = Employee(firstName: "Nikita", lastName: "Mikhailov", yearsOfService: 5)
    let e3 = Employee(firstName: "Sally", lastName: "Walkder") //  2 arg initilizer
                                                                // inherited from superclass






