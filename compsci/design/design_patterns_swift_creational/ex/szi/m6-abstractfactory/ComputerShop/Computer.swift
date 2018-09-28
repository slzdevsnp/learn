//
//  Computer.swift
//  ComputerShop
//
//  Created by Sviatoslav Zimine on 9/24/17.
//  Copyright © 2017 sviatoslav.zimin. All rights reserved.
//

import UIKit

//computer is composed of computer parts
struct Computer: CustomStringConvertible, Priced {
    public var finish: Finish
    public var storage: Storage
    public var processor: Processor
    public var memory: Memory
    public var price: Float {
        get {
            let total = finish.price + storage.price + processor.price + memory.price
            return total
        }
    }
    //    public var price
    public var description: String {
        get {
            return "\nYour configuration:\(finish) \(storage) \(processor) \(memory)\nTotal: $\(price)"
        }
    }
}

