//
//  MemoryUtil.swift
//  Prototype
//
//  Created by Sviatoslav Zimine on 9/23/17.
//  Copyright © 2017 sviatoslav.zimin. All rights reserved.
//

import Foundation

public struct MemoryUtil {
    
    public static func address(_ o: UnsafeRawPointer) -> String {
        let address = Int(bitPattern: o)
        return "object address: " + String(format: "%p", address)
    }
    
    public static func address<T: AnyObject>(_ ref: T) -> String {
        let address = unsafeBitCast(ref, to: Int.self)
        return "object of type \(type(of: ref)) address: " + String(format: "%p", address)
    }
}
