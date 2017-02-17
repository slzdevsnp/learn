import Foundation

class Person {
    let firstName: String
    let lastName: String
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
}

class Student: Person {
    // "override" keyword is required here
    override var fullName: String {
        get {
            return super.fullName.uppercaseString
        }
    }

    deinit {
        println("Student: \(fullName) is going away")
    }
}

var p: Person! = Person(firstName: "Alex", lastName: "Vollmer")
var s: Student! = Student(firstName: "Ferris", lastName: "Bueller")

// nil-out references to force deallocation
p = nil
s = nil
