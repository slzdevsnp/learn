//: Playground - noun: a place where people can play

import Foundation


///MARK: - sublcass syntax, a computed property

class Person{
    
    //fields
    var firstName = "Fred", lastName = "Flintstone"
    var adress    = "Bedrock, CA"
    var email     = "fred@bedrok.io"
    
    //a property
    var fullName: String{
        set {
            var parts = newValue.characters.split{$0 == " "}.map{String($0)}  // ? swift2
            firstName = parts.count > 0 ? String(parts[0]) : ""
            lastName =  parts.count > 1 ? String(parts[1]) : ""
        }
        get { return firstName + " " + lastName }
    }
    
    func changeEmailAdress(email:String){
        self.email = email
    }
    final func sendEmailTo (subject:String, body:String){ /*...*/} // final cannot override func in subclasses

    //member defined as a closure
    var mailingAdress: String {
        return fullName + "\n" + adress
    }
    
}

//a subClass
class Employee : Person{
    var employeeID = 0
    override func changeEmailAdress(email: String) { /*...*/ } // remplementing a function in a subclass
    
    func          changeEmailAdress(name:String, domain:String){ //overloading a function (different signature)
        self.email = name + "@" + domain
    
    }
    //override func sendEmailTo(subject:String, body:String){ /*.... */ }  //cannot override a final func
    
    //can override a property
    override var fullName: String{  get{/*..*/ return ""}  set{/*..*/} }
        
    //can also oveeride a field  by redefining it as a property  BUT this violates 'a No suprise' principle

}

///MARK: - properties

//properties are dangeorouse for maitenance ..
//you should be able to completely change a class implementation  without the client's noticying


var barney = Person()
barney.fullName
barney.fullName = "Joe Average"
barney.firstName
barney.lastName
barney.mailingAdress





