//: AddressBook

import Foundation


///MARK: - Basic contact info
/// Title enum
public enum Title: String {
    case mr = "Mr."
    case ms = "Ms."
    case none = "-"
}

extension Title: CustomStringConvertible {
    
    public var description: String {
        
        var result: String
        switch self {
        case .ms:
            result = Title.ms.rawValue
        case .mr:
            result = Title.mr.rawValue
        default:
            result = Title.none.rawValue
        }
        
        return result
    }
}

/// Basic person info
public struct BasicInfo {
    
    public var title: Title?
    public var fullname: String
}

extension BasicInfo: CustomStringConvertible {
    
    public var description: String {
        var result = fullname
        
        if let title = title {
            result = "\(title) ".appending(result)
        }
        
        return result
    }
}

/// Record representing an entry in the Address Book
public struct Contact {
    
    public var info: BasicInfo
    public var address: Address?
    public var employment: Employment?
    public var notes: String?
}

// needed for search/hashing
extension Contact: Equatable {
    public static func == (lhs: Contact, rhs: Contact) -> Bool {
        return lhs.info.fullname == rhs.info.fullname
    }
}

extension Contact: CustomStringConvertible {
    public var description: String {
        
        var result = "\(info)"
        
        if let address = address {
            result = result.appending("\n\t \(address)")
        }
        
        if let employment = employment {
            result = result.appending("\n\t \(employment)")
        }
        
        if let notes = notes {
            result = result.appending(notes)
        }
        
        return result
    }
}

///MARK: - Address
/// Address record
public struct Address {
    
    public var street: String
    public var city: String
    public var state: String
    public var zipCode: String
    public var country: String
    public var phoneNumber: String?
}

extension Address: CustomStringConvertible {
    
    public var description: String {
        
        var result = "\(street), \(city), \(state), \(zipCode), \(country)"
        
        if let phoneNumber = phoneNumber {
            result = result.appending(", \(phoneNumber)")
        }
        return result
    }
}

///MARK: - Employment
/// Employment related information
public struct Employment {
    
    public var company: String
    public var occupation: String
    public var workAddress: Address
}

extension Employment: CustomStringConvertible {
    
    public var description: String {
        
        return "\(company), \(occupation), \(workAddress)"
    }
}

public class AddressBook {
    
    fileprivate var internalContacts = [Contact]()
    
    public var contacts: [Contact] {
        
        get {
            return internalContacts
        }
    }
    
    public func search(name: String) -> [Contact] {
        
        let matchingContacts = internalContacts.filter { $0.info.fullname.contains(name) }
        return matchingContacts
    }
    
    public func add(contact: Contact) {
        
        if internalContacts.index(of: contact) == nil {
            internalContacts.append(contact)
            // sort by name
            internalContacts.sort { $0.info.fullname < $1.info.fullname }
        }
    }
    
    public func remove(contact: Contact) {
        
        if let index = internalContacts.index(of: contact) {
            internalContacts.remove(at: index)
        }
    }
}

extension AddressBook: CustomStringConvertible {
    public var description: String {
        
        var descriptions = String()
        
        contacts.forEach { (contact) in
            descriptions.append("\(contact)\n")
        }
        
        return descriptions
    }
}


let addressBook = AddressBook()

let info = BasicInfo(title: .mr, fullname: "Joe Black")
let employment = Employment(company: "StarDust Inc.", occupation: "engineer", workAddress: Address(street: "1, Brannon Str.", city: "Los Angeles", state: "CA", zipCode: "90026", country: "U.S.", phoneNumber: nil))

let contactPrototype = Contact(info: info, address: nil, employment: employment, notes: nil)

var fordP = contactPrototype
fordP.info.fullname = "Ford Prefect"

var johnD = contactPrototype
johnD.info.fullname = "John Doe"

var maryM = contactPrototype
maryM.info.fullname = "Mary Mitchell"
maryM.info.title = .ms
maryM.employment?.workAddress.city = "Metairie"
maryM.employment?.workAddress.street = "16, Shadowmar Drv."
maryM.employment?.workAddress.zipCode = "70006"
maryM.employment?.workAddress.state = "LA"

print(contactPrototype)
print(fordP)
print(johnD)
print(maryM)

addressBook.add(contact: contactPrototype)
addressBook.add(contact: fordP)
addressBook.add(contact: johnD)
addressBook.add(contact: maryM)

print(addressBook)

let searchTerm = "Joh"
let results = addressBook.search(name: searchTerm)

print("Search results for \"\(searchTerm)\"")
results.forEach { (contact) in
    print(contact)
}

if let contact = results.first {
    print("\nRemoving contact \(contact)")
    addressBook.remove(contact: contact)
}
print("\nAddressBook after removing contact")
print(addressBook)
