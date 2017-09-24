//: Prototype

//: ## Cloning Value Types
//: In Swift, value types are copied by default.
//: Whenever we assign a value type to a new variable or constant, or when it is passed to a function, Swift copies it, so it applies the Prototype pattern automatically.
//: All built-in numeric types, Strings, booleans, enumerations, collections and tuples are implemented as structs. Therefore, whenever you assign a built-in type, its value gets copied and used to create the clone.
//: The clone points to a new instance. Therefore, if we change any of the copied values of this cloned instance, the original instance - the prototype - won’t be affected.
import Foundation

public struct Contact: CustomStringConvertible {
    public var firstName: String
    public var lastName: String
    
    public init( firstName: String, lastName: String ) {
        self.firstName = firstName
        self.lastName = lastName
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

// custom value type
var contactPrototype = Contact(firstName: "Joe", lastName: "Black")

// assign to a new variable
var contactCopy = contactPrototype

// the address of the two objects differs
print(MemoryUtil.address(&contactPrototype))
print(MemoryUtil.address(&contactCopy))

// but their contents are still the same, since we haven't changed the values of the clone yet
print(contactPrototype)
print(contactCopy)

assert(contactPrototype == contactCopy, "Contents should not differ")

// now, I am going to change the first and the last name for the contact clone
contactCopy.firstName = "Ford"
contactCopy.lastName = "Prefect"

assert(contactPrototype != contactCopy, "Contents must differ")

// and indeed, the two contacts have different values for first- and lastname
print(contactPrototype)
print(contactCopy)

// Conclusion: we get the prototype behavior for free for value types
//: copy-on-write optimization
//  Swift sometimes applies optimizations to built-in types to reduce the amount of copying.
//  Let's demonstrate this via a straightforward example

//  First, I create an array of ints
var numbers = [1, 2, 3]
var numbersCopy = numbers

print(MemoryUtil.address(numbers))
print(MemoryUtil.address(numbersCopy))

// Arrays are value types in Swift, so the two instances should have different addresses; however, because of the so-called copy-on-write optimization, the two arrays share the same storage until you modify one of the copies.
numbersCopy.append(4)
print(MemoryUtil.address(numbers))
print(MemoryUtil.address(numbersCopy))
// copy-on-write executed -> the addresses of array and clonedArray are now different
//  The array being modified replaces its storage with a uniquely owned copy of itself, which is then modified in place.

//: Note that copy-on-write is a feature specifically added to Swift collections arrays and dictionaries; you don't get it for free in your own data types.
