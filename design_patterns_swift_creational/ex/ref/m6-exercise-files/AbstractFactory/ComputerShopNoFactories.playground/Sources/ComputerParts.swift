// Computer Parts

import UIKit

//MARK: - Finish
public protocol Finish: CustomStringConvertible {
    var color: UIColor {get}
    var price: Float {get}
    
    var description: String {get}
}

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
public protocol Storage: CustomStringConvertible {
    var type: StorageType {get}
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

public struct SmallFlash: Storage {
    public var type = StorageType.flash
    public var size = StorageSize.small
    public var price = Float(500)
    
    public var description: String {
        return "\n\tStorage: \(size) \(type)"
    }
    
    public init() {}
}

public struct MediumFlash: Storage {
    public var type = StorageType.flash
    public var size = StorageSize.medium
    public var price = Float(650)
    
    public var description: String {
        return "\n\tStorage: \(size) \(type)"
    }
    
    public init() {}
}

public struct HugeFlash: Storage {
    public var type = StorageType.flash
    public var size = StorageSize.huge
    public var price = Float(900)
    
    public var description: String {
        return "\n\tStorage: \(size) \(type)"
    }
    
    public init() {}
}

public struct SmallHardDisk: Storage {
    public var type = StorageType.hardDisk
    public var size = StorageSize.small
    public var price = Float(100)
    
    public var description: String {
        return "\n\tStorage: \(size) \(type)"
    }
    
    public init() {}
}

public struct MediumHardDisk: Storage {
    public var type = StorageType.hardDisk
    public var size = StorageSize.medium
    public var price = Float(300)
    
    public var description: String {
        return "\n\tStorage: \(size) \(type)"
    }
    
    public init() {}
}

public struct HugeHardDisk: Storage {
    public var type = StorageType.hardDisk
    public var size = StorageSize.huge
    public var price = Float(450)
    
    public var description: String {
        return "\n\tStorage: \(size) \(type)"
    }
    
    public init() {}
}

//MARK: - Processor
public protocol Processor: CustomStringConvertible {
    var type: ProcessorType {get}
    var frequency: ProcessorFrequency {get}
    var price: Float {get}
}

public enum ProcessorType: String {
    case dualCore = "Dual Core"
    case quadCore = "Quad Core"
}

public enum ProcessorFrequency: String {
    case low = "1.4GHz"
    case fast = "2.4GHz"
    case turbo = "3.2GHz"
}

public struct BasicProcessor: Processor {
    public var type = ProcessorType.dualCore
    public var frequency = ProcessorFrequency.low
    public var price = Float(250)
    
    public var description: String {
        return "\n\tProcessor: \(type) \(frequency.rawValue)"
    }
    
    public init() {}
}

public struct FastProcessor: Processor {
    public var type = ProcessorType.dualCore
    public var frequency = ProcessorFrequency.fast
    public var price = Float(320)
    
    public var description: String {
        return "\n\tProcessor: \(type) \(frequency.rawValue)"
    }
    
    public init() {}
}

public struct TurboProcessor: Processor {
    public var type = ProcessorType.dualCore
    public var frequency = ProcessorFrequency.turbo
    public var price = Float(490)
    
    public var description: String {
        return "\n\tProcessor: \(type) \(frequency.rawValue)"
    }
    
    public init() {}
}

public struct HighEndProcessor: Processor {
    public var type = ProcessorType.quadCore
    public var frequency = ProcessorFrequency.turbo
    public var price = Float(900)
    
    public var description: String {
        return "\n\tProcessor: \(type) \(frequency.rawValue)"
    }
    
    public init() {}
}

//MARK: - Memory
public protocol Memory: CustomStringConvertible {
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

public struct BasicMemory: Memory {
    public var size = MemorySize.basic
    public var type = MemoryType.ddr3
    public var frequency = MemorySpeed.fast
    public var price = Float(200)
    
    public var description: String {
        return "\n\tMemory: \(size.rawValue) \(type.rawValue) \(frequency.rawValue)"
    }
    
    public init() {}
}

public struct AdvancedMemory: Memory {
    public var size = MemorySize.medium
    public var type = MemoryType.lpddr3
    public var frequency = MemorySpeed.fast
    public var price = Float(400)
    
    public var description: String {
        return "\n\tMemory: \(size.rawValue) \(type.rawValue) \(frequency.rawValue)"
    }
    
    public init() {}
}

public struct ProMemory: Memory {
    public var size = MemorySize.pro
    public var type = MemoryType.lpddr3
    public var frequency = MemorySpeed.turbo
    public var price = Float(600)
    
    public var description: String {
        return "\n\tMemory: \(size.rawValue) \(type.rawValue) \(frequency.rawValue)"
    }
    
    public init() {}
}
























