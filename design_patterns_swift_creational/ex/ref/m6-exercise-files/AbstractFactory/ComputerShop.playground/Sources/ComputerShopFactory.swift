// ComputerFactory

import UIKit

public enum ComputerType {
    case basic
    case office
    case developer
    case highEnd
}

public class ComputerFactory {
    public func makeFinish() -> Finish? {
        return nil
    }
    public func makeStorage() -> Storage? {
        return nil
    }
    public func makeProcessor() -> Processor? {
        return nil
    }
    public func makeMemory() -> Memory? {
        return nil
    }
    
    public final class func makeFactory(type: ComputerType) -> ComputerFactory {
        var factory: ComputerFactory
        switch(type) {
        case .basic: factory = BasicComputerFactory()
        case .office: factory = OfficeComputerFactory()
        case .developer: factory = DeveloperComputerFactory()
        case .highEnd: factory = HighEndComputerFactory()
        }
        return factory
    }
}

fileprivate class BasicComputerFactory: ComputerFactory {
    override func makeFinish() -> Finish? {
        return WhiteFinish()
    }
    
    override func makeStorage() -> Storage? {
        return SmallHardDisk()
    }
    
    override func makeProcessor() -> Processor? {
        return BasicProcessor()
    }
    
    override func makeMemory() -> Memory? {
        return BasicMemory()
    }
}

fileprivate class OfficeComputerFactory: ComputerFactory {
    override func makeFinish() -> Finish? {
        return WhiteFinish()
    }
    
    override func makeStorage() -> Storage? {
        return MediumHardDisk()
    }
    
    override func makeProcessor() -> Processor? {
        return FastProcessor()
    }
    
    override func makeMemory() -> Memory? {
        return AdvancedMemory()
    }
}

fileprivate class DeveloperComputerFactory: ComputerFactory {
    override func makeFinish() -> Finish? {
        return WhiteFinish()
    }
    
    override func makeStorage() -> Storage? {
        return MediumFlash()
    }
    
    override func makeProcessor() -> Processor? {
        return TurboProcessor()
    }
    
    override func makeMemory() -> Memory? {
        return ProMemory()
    }
}

fileprivate class HighEndComputerFactory: ComputerFactory {
    override func makeFinish() -> Finish? {
        return BlackFinish()
    }
    
    override func makeStorage() -> Storage? {
        return HugeFlash()
    }
    
    override func makeProcessor() -> Processor? {
        return TurboProcessor()
    }
    
    override func makeMemory() -> Memory? {
        return ProMemory()
    }
}

//MARK: - Computer Parts

//MARK: - Finish
public protocol Finish: CustomStringConvertible {
    var color: UIColor {get}
    var price: Float {get}
    
    var description: String {get}
}

struct WhiteFinish: Finish {
    public var color = UIColor.white
    public var price = Float(300)
    
    public var description: String = "\n\tFinish: White"
    public init() {}
}

struct BlackFinish: Finish {
    public var color = UIColor.black
    public var price = Float(400)
    
    public var description: String = "\n\tFinish: Black"
    public init() {}
}

//MARK: - Storage
public protocol Storage: CustomStringConvertible {
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

struct SmallFlash: Storage {
    public var storageType = StorageType.flash
    public var size = StorageSize.small
    public var price = Float(500)
    
    public var description: String {
        return "\n\tStorage: \(size) \(storageType)"
    }
    
    public init() {}
}

struct MediumFlash: Storage {
    public var storageType = StorageType.flash
    public var size = StorageSize.medium
    public var price = Float(650)
    
    public var description: String {
        return "\n\tStorage: \(size) \(storageType)"
    }
    
    public init() {}
}

struct HugeFlash: Storage {
    public var storageType = StorageType.flash
    public var size = StorageSize.huge
    public var price = Float(800)
    
    public var description: String {
        return "\n\tStorage: \(size) \(storageType)"
    }
    
    public init() {}
}

struct SmallHardDisk: Storage {
    public var storageType = StorageType.hardDisk
    public var size = StorageSize.small
    public var price = Float(100)
    
    public var description: String {
        return "\n\tStorage: \(size) \(storageType)"
    }
    
    public init() {}
}

struct MediumHardDisk: Storage {
    public var storageType = StorageType.hardDisk
    public var size = StorageSize.medium
    public var price = Float(300)
    
    public var description: String {
        return "\n\tStorage: \(size) \(storageType)"
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

struct BasicProcessor: Processor {
    public var type = ProcessorType.dualCore
    public var frequency = ProcessorFrequency.low
    public var price = Float(250)
    
    public var description: String {
        get {
            return "\n\tProcessor: \(type) \(frequency.rawValue)"
        }
    }
    
    public init() {}
}

struct FastProcessor: Processor {
    public var type = ProcessorType.dualCore
    public var frequency = ProcessorFrequency.low
    public var price = Float(320)
    
    public var description: String {
        get {
            return "\n\tProcessor: \(type) \(frequency.rawValue)"
        }
    }
    
    public init() {}
}


struct TurboProcessor: Processor {
    public var type = ProcessorType.quadCore
    public var frequency = ProcessorFrequency.turbo
    public var price = Float(490)
    
    public var description: String {
        get {
            return "\n\tProcessor: \(type) \(frequency.rawValue)"
        }
    }
    
    public init() {}
}

struct HighEndProcessor: Processor {
    public var type = ProcessorType.quadCore
    public var frequency = ProcessorFrequency.turbo
    public var price = Float(900)
    
    public var description: String {
        get {
            return "\n\tProcessor: \(type) \(frequency.rawValue)"
        }
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

struct BasicMemory: Memory {
    var size = MemorySize.basic
    var type = MemoryType.ddr3
    var frequency = MemorySpeed.fast
    var price = Float(200)
    
    public var description: String {
        get {
            return "\n\tMemory: \(size) \(type) \(frequency.rawValue)"
        }
    }
}

struct AdvancedMemory: Memory {
    var size = MemorySize.medium
    var type = MemoryType.lpddr3
    var frequency = MemorySpeed.fast
    var price = Float(400)
    
    public var description: String {
        get {
            return "\n\tMemory: \(size) \(type) \(frequency.rawValue)"
        }
    }
}

struct ProMemory: Memory {
    var size = MemorySize.pro
    var type = MemoryType.lpddr3
    var frequency = MemorySpeed.turbo
    var price = Float(600)
    
    public var description: String {
        get {
            return "\n\tMemory: \(size) \(type) \(frequency.rawValue)"
        }
    }
}
