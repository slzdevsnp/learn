
import Foundation 

public struct Contact: CustomStringConvertible {
 	public var firstName: String 
 	public var lastName : String

 	public var description: String {
 		return "\(firstName), \(lastName)"
 	}

}

extension Contact: Equatable {
	public static func ==(rhs: Contact, lhs: Contact) -> Bool {
     return rhs.lastName == lhs.lastName && rhs.firstName == lhs.firstName
	}
}


var contactPrototype = Contact(firstName: "Joe", lastName: "Black")

//value copy the prototype instance (their memory adresses are different)
var contactCopy  =  contactPrototype

print(MemoryUtil.address(&contactPrototype))  
print(MemoryUtil.address(&contactCopy))  //expect different address

print(contactPrototype) 
print(contactCopy)  //expect same contents

assert(contactPrototype == contactCopy, "Contents expected to mach")

contactCopy.lastName = "Ford"
assert(contactPrototype != contactCopy, "Contents expected to differ")


///////////////////////////////////////
public struct MemoryUtil {

	public static func address(_ o: UnsafeRawPointer) -> String {
		let address = unsafeBitCast(o, to: Int.self) // avoid using unsafeBitCast func in prod code
		return String(format: "%p", address)
	}
}