//
//  ContactShallow.swift
//  Prototype
//
//  Created by Sviatoslav Zimine on 9/23/17.
//  Copyright © 2017 sviatoslav.zimin. All rights reserved.
//

import Foundation

public class ContactShallow : NSCopying, CustomStringConvertible  {
    
    public var firstName: String
    public var lastName : String
    public var workAddress: WorkAddress
    
    public init(firstName: String, lastName: String, workAddress: WorkAddress){
        self.firstName = firstName
        self.lastName = lastName
        self.workAddress = workAddress
    }
    public var description: String {
        return "\(firstName), \(lastName) at: \(workAddress)"
    }
    // NSCopying protocol  for cloning
    public func copy(with zone: NSZone? = nil) -> Any {
        // return a new instance
        return ContactShallow(firstName: self.firstName, lastName: self.lastName,
                              workAddress: self.workAddress) //<-- this is responsible for shallow copy
    }
}

extension ContactShallow: Equatable {
    public static func ==(lhs: ContactShallow, rhs: ContactShallow) -> Bool {
        return lhs.lastName == rhs.lastName &&
            lhs.firstName == rhs.firstName
    }
}
