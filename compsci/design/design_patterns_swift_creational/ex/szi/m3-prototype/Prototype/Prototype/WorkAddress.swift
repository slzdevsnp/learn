//
//  WorkAddress.swift
//  Prototype
//
//  Created by Sviatoslav Zimine on 9/23/17.
//  Copyright © 2017 sviatoslav.zimin. All rights reserved.
//

import Foundation

public class WorkAddress: CustomStringConvertible, NSCopying {
    
    public var streetAddress: String
    public var city: String
    public var zip: String
    
    public init(streetAddress: String, city: String, zip: String){
        self.streetAddress = streetAddress
        self.city = city
        self.zip = zip
    }
    
    public func copy(with zone: NSZone? = nil) -> Any {
        return WorkAddress(streetAddress: self.streetAddress,
                           city: self.city, zip: self.zip)
    }
    
    public var description: String {
        return "\(self.streetAddress), \(self.city), \(self.zip)"
    }
    
}
