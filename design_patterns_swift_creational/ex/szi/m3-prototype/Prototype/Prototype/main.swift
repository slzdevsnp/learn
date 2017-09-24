//
//  main.swift
//  Prototype
//
//  Created by Sviatoslav Zimine on 9/23/17.
//  Copyright © 2017 sviatoslav.zimin. All rights reserved.
//

import Foundation

var contactPrototype = ContactBasic(firstName: "Joe", lastName: "Black")
var contactCopy  = contactPrototype

print(MemoryUtil.address(&contactPrototype))
print(MemoryUtil.address(&contactCopy))

assert(contactPrototype == contactCopy, "Contents expected to match")

contactCopy.lastName = "Ford"
assert(contactPrototype != contactCopy, "Contents expected to differ")

print(contactPrototype)
print(contactCopy)

//: Copy-on-write optimization
print("***** copy-on-write optimization")
print("*********************************")

var numbers: [Int] = [1,2,3]
var numbersCopy = numbers
print("  for swift collections")
print(MemoryUtil.address(numbers))
print(MemoryUtil.address(numbersCopy)) //point to the same location

numbersCopy.append(4)
print("  after changing 1 element")
print(MemoryUtil.address(numbers))
//not the same location anymore
 print(MemoryUtil.address(numbersCopy))


//: Prototype with reference types
print("***** Prototype with reference type ")
print("************************************")
var contactRPrototype = ContactR(firstName: "Allan", lastName: "Gordon")
var anotherRcontact = contactRPrototype
print("addresses of reference objects")
print(MemoryUtil.address(contactRPrototype))
print(MemoryUtil.address(anotherRcontact))

anotherRcontact.lastName = "Borodin"
anotherRcontact.firstName = "Prefect"
print("after changing an attribute in a copy expect both ref copies to change")
print(contactRPrototype)
print(anotherRcontact)

var  contactRCopy  = contactRPrototype.copy() as! ContactR //must cast to type
contactRCopy.firstName = "Bill"
contactRCopy.lastName =  "Murrey"
print("after NSCopying and changing 1 copy")
print(contactRPrototype)
print(contactRCopy)
print(MemoryUtil.address(contactRPrototype))
print(MemoryUtil.address(contactRCopy))


//: Shallow and deep copy
print("***** Shallow and Deep copy ")
print("************************************")
print ("** Shallow copy")
var contactusPrototype = ContactShallow(firstName: "Joe", lastName: "Black",
                            workAddress: WorkAddress(streetAddress: "1, Brannon Street",
                                                     city: "Los Angeles",
                                                     zip: "90026"))

var contactusCopy = contactusPrototype.copy() as! ContactShallow
print(MemoryUtil.address(contactusPrototype))
print(MemoryUtil.address(contactusCopy))

//lets change data for copy
contactusCopy.firstName = "Fred"
contactusCopy.lastName = "Paretto"
contactusCopy.workAddress.city = "Metairie"
contactusCopy.workAddress.streetAddress = "16 Shadow drv"
contactusCopy.workAddress.zip = "70006"

print("after modifying the data of the copy, address is the same on both <-- Shallow Copy")
print(contactusPrototype)
print(contactusCopy)
//to confirm
print(MemoryUtil.address(contactusPrototype.workAddress))
print(MemoryUtil.address(contactusCopy.workAddress))

print ("** Deep copy")
var contactusPrototypeBis = ContactDeep(firstName: "Joe", lastName: "Black",
                                        workAddress: WorkAddress(streetAddress: "1, Brannon Street",
                                                                 city: "Los Angeles",
                                                                 zip: "90026"))

var contactusCopyBis = contactusPrototypeBis.copy() as! ContactDeep
contactusCopyBis.firstName = "Fred"
contactusCopyBis.lastName = "Paretto"
contactusCopyBis.workAddress.city = "Metairie"
contactusCopyBis.workAddress.streetAddress = "16 Shadow drv"
contactusCopyBis.workAddress.zip = "70006"
print(" after modifying the data of the deep opy, address is different for both")
print(contactusPrototypeBis)
print(contactusCopyBis)
print(MemoryUtil.address(contactusPrototype.workAddress))
print(MemoryUtil.address(contactusCopy.workAddress))


print("")
print("*************************")
print("*                       *")
print("*   AddressBook demo    *")
print("*************************")


let addressBook = AddressBook()

let infotemplate = BasicInfo(title: .mr, fullname: "YourFirstName LastName")
let addrtemplate = Address(street: "1 Brannon Str", city: "Los Angeles" ,state: "CA",zip: "90026" , country: "US" ,phoneNumber: nil)
let employtemplate = Employment(company: "StarDust Inc.", occupation: "Engineer", workAddress: addrtemplate)

let contactosPrototype = Contact(info: infotemplate, address: nil, employment: employtemplate, notes: nil)

var fordP = contactosPrototype
fordP.info.fullname = "Francesca Prefecta"
fordP.info.title = .dr
fordP.employment?.occupation = "Manager"

var johnD = contactosPrototype
johnD.info.fullname = "John Doe"


var maryM = contactosPrototype
maryM.info.fullname = "Mary Mitchel"
maryM.info.title = .ms
maryM.employment?.workAddress.city = "Metairie"
maryM.employment?.workAddress.street = "16 Shadowmar Drw"
maryM.employment?.workAddress.state = "LA"
maryM.employment?.workAddress.zip = "70006"
maryM.employment?.workAddress.phoneNumber = "354-787-04-49"

maryM.employment?.company = "OrganicFood LLC"

var madY = contactosPrototype
madY.info.fullname = "Madeline Allright"
madY.info.title = .ms

print(contactosPrototype)
print(fordP)
print(johnD)
print(maryM)

addressBook.add(contact: contactosPrototype)
addressBook.add(contact: fordP)
addressBook.add(contact: johnD)
addressBook.add(contact: maryM)
addressBook.add(contact: madY)

print("\n**printing the addressbook**\n")
print(addressBook)

//trying the search

let seartchItem = "Ma"
let results = addressBook.search(name: seartchItem)
print("\n**Search results for \"\(seartchItem)\":")
results.forEach { (contact) in
    print("\(contact)\n")
}

//testing the remove

if let contact = results.first {
    print("removing contact \(contact)")
    addressBook.remove(contact: contact)
}
print("\n**After removal elements count of the addressbook: \(addressBook.count())")
print(addressBook)

