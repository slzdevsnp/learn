//
//  Contact.swift
//  Prototype
//
//  Created by Sviatoslav Zimine on 9/23/17.
//  Copyright © 2017 sviatoslav.zimin. All rights reserved.
//

import Foundation

public struct ContactBasic: CustomStringConvertible {
    public var firstName: String
    public var lastName : String
    
    public var description: String {
        return "\(firstName), \(lastName)"
    }
}

extension ContactBasic: Equatable {
    public static func ==(lhs: ContactBasic, rhs: ContactBasic) -> Bool {
        return rhs.lastName == lhs.lastName &&
               rhs.firstName == lhs.firstName
    }
}


