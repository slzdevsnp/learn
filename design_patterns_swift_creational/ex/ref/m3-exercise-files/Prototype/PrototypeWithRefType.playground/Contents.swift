//: Prototype with class type

import Foundation

public class Contact: NSCopying, CustomStringConvertible {
    
    public var firstName: String
    public var lastName: String
    
    public init (firstName: String, lastName: String) {
        
        self.firstName = firstName
        self.lastName = lastName
    }
    
    public func copy(with zone: NSZone? = nil) -> Any {
        return Contact(firstName: self.firstName, lastName: self.lastName)
    }
    
    public var description: String {
        return "\(firstName), \(lastName)"
    }
}

extension Contact: Equatable {
    /// equality operator
    public static func ==(lhs: Contact, rhs: Contact) -> Bool {
        return lhs.firstName == rhs.firstName && lhs.lastName == rhs.lastName
    }
}

// Custom value type
var contactPrototype = Contact(firstName: "Joe", lastName: "Black")
// assign to a new var
var anotherContact = contactPrototype

// Let's inspect the memory addresses of the two instances
// Since Contact is a reference type, it won't be copied upon assignment
print(MemoryUtil.address(contactPrototype))
print(MemoryUtil.address(anotherContact))

// define description
print(contactPrototype)
print(anotherContact)


// now define the equatable extension
assert(contactPrototype == anotherContact, "Contents should match")

anotherContact.lastName = "Prefect"
anotherContact.firstName = "Ford"

print(contactPrototype)
print(anotherContact)

// assertion fails, because reference types are not copied upon assignment
// assert(contactPrototype != contactCopy, "Contacts should differ")

// we must cast the copy to the actual type, since copy returns Any
var contactCopy  = contactPrototype.copy() as! Contact

print(MemoryUtil.address(contactPrototype))
print(MemoryUtil.address(contactCopy))

// let's change the properties of the clone
contactCopy.firstName = "Joe"
contactCopy.lastName = "Black"

// the clone and the prototype are two individual instances, therefore changing the values of the clone won't affect the prototype
print(contactPrototype)
print(contactCopy)

assert(contactPrototype != contactCopy, "Contacts should differ")