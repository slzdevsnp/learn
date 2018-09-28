//
//  AddressBook.swift
//  Prototype
//
//  Created by Sviatoslav Zimine on 9/23/17.
//  Copyright © 2017 sviatoslav.zimin. All rights reserved.
//


// good working blueprint for AddressBook implementation

import Foundation

public enum Title: String {
    case mr = "Mr."
    case ms = "Ms."
    case dr = "Dr."
    case none = ""
}

public struct BasicInfo {
    public var title: Title?
    public var fullname: String
}
extension BasicInfo: CustomStringConvertible{
    public var description: String {
        var result = fullname
        if let title = title {
            result = "\(title.rawValue) ".appending(result)
        }
        return result
    }
}
public struct Address {
    public var street: String
    public var city: String
    public var state: String
    public var zip: String
    public var country: String
    public var phoneNumber: String?
}
extension Address: CustomStringConvertible{
    public var description: String {
        var result = "\(street)\n\(city) \(state) \(zip)\n\(country)"
        if let phoneNumber = phoneNumber {
            result = result.appending("\nphone: \(phoneNumber)")
        }
        return result
    }
}
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
//implement Contact
public struct Contact {
    public var info: BasicInfo //mandatory all others are optional
    public var address: Address?
    public var employment: Employment?
    public var notes: String?
}

extension Contact: Equatable {
    public static func == (lhs: Contact, rhs: Contact) -> Bool {
        return lhs.info.fullname ==  rhs.info.fullname
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
            result = result.appending("\n \(notes)")
        }
        return result
    }
}
//: - AddressBook
public class AddressBook {
    fileprivate var internalContacts = [Contact]() //internal array of contacts
    
    public var contacts: [Contact] {
        get {
            return internalContacts
        }
    }
    
    public func add(contact: Contact){
        if internalContacts.index(of: contact) == nil { // we don't have this contact
            internalContacts.append(contact)
            //resort by fullname
            internalContacts.sort { $0.info.fullname < $1.info.fullname }
        }
    }
    
    public func remove(contact: Contact){
        if let index = internalContacts.index(of: contact){
            internalContacts.remove(at: index)
        }
    }
    
    public func search(name: String) -> [Contact] {
        let matchingContacts = internalContacts.filter { $0.info.fullname.contains(name) }
        return matchingContacts
    }
    
    public func count() -> Int {
        return contacts.count
    }
}

extension AddressBook: CustomStringConvertible {
    public var description : String {
        var descriptions: String = ""
        contacts.forEach{ (contact) in
            descriptions.append("\(contact)\n")
        }
        return descriptions
    }
}
