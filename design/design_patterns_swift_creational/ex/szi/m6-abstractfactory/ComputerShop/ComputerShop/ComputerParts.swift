//
//  ComputerParts.swift
//  ComputerShopNoFactories
//
//  Created by Sviatoslav Zimine on 9/24/17.
//  Copyright © 2017 sviatoslav.zimin. All rights reserved.
//

import UIKit

public protocol Priced {
    var price: Float {get}
}

//MARK: - Finish
public protocol Finish: Priced, CustomStringConvertible {
    var color: UIColor {get}
    var price: Float {get}
}

//conrete finish implementations
public struct WhiteFinish: Finish {
    public var color = UIColor.white
    public var price = Float(300)
    
    public var description: String = "\n\tFinish: White"
    public init() {}
}

public struct BlackFinish: Finish {
    public var color = UIColor.black
    public var price = Float(400)
    
    public var description: String = "\n\tFinish: Black"
    public init() {}
}


//MARK: - Storage
public protocol Storage: Priced, CustomStringConvertible {
    var storageType: StorageType {get}
    var size: StorageSize {get}
    var price: Float {get}
}

public enum StorageType: String, CustomStringConvertible {
    case flash = "flash"
    case hardDisk = "hard disk"
    
    public var description: String {
        return self.rawValue
    }
}

public enum StorageSize: String, CustomStringConvertible {
    case small = "512GB"
    case medium = "1TB"
    case huge = "2TB"
    
    public var description: String {
        return self.rawValue
    }
}

//concreate storage implementations
public struct SmallHardDisk : Storage {
    public var storageType = StorageType.hardDisk
    public var size = StorageSize.small
    public var price =  Float(500)
    
    public var description: String  {
        return "\n\tStorage: \(size) \(storageType)"
    }
    public init() {}
}

public struct SmallFlash : Storage {
    public var storageType = StorageType.flash
    public var size = StorageSize.small
    public var price =  Float(500)
    
    public var description: String  {
        return "\n\tStorage: \(size) \(storageType)"
    }
    public init() {}
}

public struct MediumFlash : Storage {
    public var storageType = StorageType.flash
    public var size = StorageSize.medium
    public var price =  Float(650)
    
    public var description: String  {
        return "\n\tStorage: \(size) \(storageType)"
    }
    public init() {}
}


public struct MediumHardDisk : Storage {
    public var storageType = StorageType.hardDisk
    public var size = StorageSize.medium
    public var price =  Float(400)
    
    public var description: String  {
        return "\n\tStorage: \(size) \(storageType)"
    }
    public init() {}
}

struct HugeDisk: Storage {
    public var storageType = StorageType.hardDisk
    public var size = StorageSize.huge
    public var price = Float(800)
    
    public var description: String {
        return "\n\tStorage: \(size) \(storageType)"
    }
    public init() {}
}
struct HugeFlash: Storage {
    public var storageType = StorageType.flash
    public var size = StorageSize.huge
    public var price = Float(1100)
    
    public var description: String {
        return "\n\tStorage: \(size) \(storageType)"
    }
    public init() {}
}

//MARK: - Processor
public protocol Processor: Priced, CustomStringConvertible {
    var type : ProcessorType {get}
    var frequency: ProcessorFrequency {get}
    var price: Float {get}
}

public enum ProcessorType: String {
    case monoCore = "1 Core"
    case dualCore = "Dual Core"
    case quadCore = "Quad Core"
    case octoCore =  "Octo Core"
}

public enum ProcessorFrequency: String {
    case low = "1.4 GHz"
    case fast = "2.4GHz"
    case turbo = "3.2GHz"
}

//concrete proc implementatations
public struct  BareProcessor: Processor {
    public var type = ProcessorType.monoCore
    public var frequency = ProcessorFrequency.low
    public var price = Float(150)
    
    public var description: String {
        return "\n\tProcessor: \(type) \(frequency.rawValue)"
    }
    public init() {}
}
public struct  BasicProcessor: Processor {
    public var type = ProcessorType.dualCore
    public var frequency = ProcessorFrequency.low
    public var price = Float(250)
    
    public var description: String {
        return "\n\tProcessor: \(type) \(frequency.rawValue)"
    }
    public init() {}
}

public struct  FastProcessor: Processor {
    public var type = ProcessorType.dualCore
    public var frequency = ProcessorFrequency.fast
    public var price = Float(320)
    
    public var description: String {
        return "\n\tProcessor: \(type) \(frequency.rawValue)"
    }
    public init() {}
}
public struct  TurboProcessor: Processor {
    public var type = ProcessorType.dualCore
    public var frequency = ProcessorFrequency.turbo
    public var price = Float(490)
    
    public var description: String {
        return "\n\tProcessor: \(type) \(frequency.rawValue)"
    }
    public init() {}
}
public struct  HighEndProcessor: Processor {
    public var type = ProcessorType.quadCore
    public var frequency = ProcessorFrequency.turbo
    public var price = Float(900)
    
    public var description: String {
        return "\n\tProcessor: \(type) \(frequency.rawValue)"
    }
    public init() {}
}
public struct  InsaneProcessor: Processor {
    public var type = ProcessorType.octoCore
    public var frequency = ProcessorFrequency.turbo
    public var price = Float(2500)
    
    public var description: String {
        return "\n\tProcessor: \(type) \(frequency.rawValue)"
    }
    public init() {}
}

//Mark: - Memory
public protocol Memory: Priced, CustomStringConvertible {
    var size: MemorySize {get}
    var type: MemoryType {get}
    var frequency: MemorySpeed {get}
    var price: Float {get}
}

public enum MemorySize: String {
    case basic = "8GB"
    case medium = "16GB"
    case pro = "32GB"
}

public enum MemoryType: String {
    case ddr3 = "DDR3"
    case lpddr3 = "LPDDR3"
}

public enum MemorySpeed: String {
    case fast = "1400MHz"
    case turbo = "1600MHz"
}

//concrete memeory implementations
struct BasicMemory: Memory {
    var size = MemorySize.basic
    var type = MemoryType.ddr3
    var frequency = MemorySpeed.fast
    var price = Float(200)
    
    public var description: String {
        get {
            return "\n\tMemory: \(size.rawValue) \(type.rawValue) \(frequency.rawValue)"
        }
    }
    public init() {}
}

struct AdvancedMemory: Memory {
    var size = MemorySize.medium
    var type = MemoryType.lpddr3
    var frequency = MemorySpeed.fast
    var price = Float(400)
    
    public var description: String {
        get {
            return "\n\tMemory: \(size.rawValue) \(type.rawValue) \(frequency.rawValue)"
        }
    }
    public init() {}
}

struct ProMemory: Memory {
    var size = MemorySize.pro
    var type = MemoryType.lpddr3
    var frequency = MemorySpeed.turbo
    var price = Float(600)
    
    public var description: String {
        get {
            return "\n\tMemory: \(size.rawValue) \(type.rawValue) \(frequency.rawValue)"
        }
    }
    public init() {}
}


