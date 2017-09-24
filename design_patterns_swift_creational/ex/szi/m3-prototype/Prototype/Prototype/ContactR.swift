//
//  ContactR.swift
//  Prototype
//
//  Created by Sviatoslav Zimine on 9/23/17.
//  Copyright © 2017 sviatoslav.zimin. All rights reserved.
//

import Foundation

public class ContactR : NSCopying, CustomStringConvertible  {

    public var firstName: String
    public var lastName : String
    
    public init(firstName: String, lastName: String){
        self.firstName = firstName
        self.lastName = lastName
    }
    public var description: String {
        return "\(firstName), \(lastName)"
    }
    // NSCopying protocol  for cloning
    public func copy(with zone: NSZone? = nil) -> Any {
        // return a new instance
        return ContactR(firstName: self.firstName, lastName: self.lastName)
    }
}

extension ContactR: Equatable {
    public static func ==(lhs: ContactR, rhs: ContactR) -> Bool {
        return lhs.lastName == rhs.lastName &&
            lhs.firstName == rhs.firstName
    }
}





