//: Shallow vs. deep copying

import Foundation

public class Contact: NSCopying, CustomStringConvertible {
    
    public var firstName: String
    public var lastName: String
    public var workAddress: WorkAddress
    
    public init (firstName: String, lastName: String, workAddress: WorkAddress) {
        
        self.firstName = firstName
        self.lastName = lastName
        self.workAddress = workAddress
    }
    
    public func copy(with zone: NSZone? = nil) -> Any {
//        return Contact(firstName: self.firstName, lastName: self.lastName, workAddress: self.workAddress)
        return Contact(firstName: self.firstName, lastName: self.lastName, workAddress: self.workAddress.copy() as! WorkAddress)
    }
    
    public var description: String {
        return "\(firstName), \(lastName), \(workAddress)"
    }
}

extension Contact: Equatable {
    /// equality operator
    public static func ==(lhs: Contact, rhs: Contact) -> Bool {
        return lhs.firstName == rhs.firstName && lhs.lastName == rhs.lastName
    }
}

public class WorkAddress: NSCopying, CustomStringConvertible {
    
    public var streetAddress: String
    public var city: String
    public var zip: String
    
    public init( streetAddress: String, city: String, zip: String ) {
        self.streetAddress = streetAddress
        self.city = city
        self.zip = zip
    }
    
    public func copy(with zone: NSZone? = nil) -> Any {
        return WorkAddress(streetAddress: self.streetAddress, city: self.city, zip: self.zip)
    }
    
    public var description: String {
        return "\(streetAddress), \(city), \(zip)"
    }
}

var contactPrototype = Contact(firstName: "Joe", lastName: "Black", workAddress: WorkAddress(streetAddress: "Stanton str. 15", city: "San Francisco", zip: "42012"))

var contactCopy = contactPrototype.copy() as! Contact

print(MemoryUtil.address(contactPrototype))
print(MemoryUtil.address(contactCopy))

print(contactPrototype)
print(contactCopy)

contactCopy.firstName = "Ford"
contactCopy.lastName = "Prefect"
contactCopy.workAddress.city = "Cupertino"

print(contactPrototype)
print(contactCopy)

print(MemoryUtil.address(contactPrototype.workAddress))
print(MemoryUtil.address(contactCopy.workAddress))
