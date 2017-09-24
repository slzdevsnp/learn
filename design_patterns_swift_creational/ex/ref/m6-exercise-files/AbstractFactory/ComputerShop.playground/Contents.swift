//: Abstract Factory

import UIKit

struct Computer: CustomStringConvertible {
    public var finish: Finish
    public var storage: Storage
    public var processor: Processor
    public var memory: Memory
    
    public var price: Float {
        get {
            let total = finish.price + storage.price + processor.price
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

//:### Instantiate the factory responsible for creating the parts required for the given configuration
// Basic computer factory
let basicComputerFactory = ComputerFactory.makeFactory(type: .basic)

if let finish = basicComputerFactory.makeFinish(),
    let storage = basicComputerFactory.makeStorage(),
    let processor = basicComputerFactory.makeProcessor(),
    let memory = basicComputerFactory.makeMemory() {

    let computer = Computer(finish: finish, storage: storage, processor: processor, memory: memory)
    print(computer)
}

// Developer computer factory
let developerComputerFactory = ComputerFactory.makeFactory(type: .developer)

if let finish = developerComputerFactory.makeFinish(),
    let storage = developerComputerFactory.makeStorage(),
    let processor = developerComputerFactory.makeProcessor(),
    let memory = developerComputerFactory.makeMemory() {
    
    let computer = Computer(finish: finish, storage: storage, processor: processor, memory: memory)
    print(computer)
}

// High-end computer factory
let highEndComputerFactory = ComputerFactory.makeFactory(type: .highEnd)

if let finish = highEndComputerFactory.makeFinish(),
    let storage = highEndComputerFactory.makeStorage(),
    let processor = highEndComputerFactory.makeProcessor(),
    let memory = highEndComputerFactory.makeMemory() {
    
    let computer = Computer(finish: finish, storage: storage, processor: processor, memory: memory)
    print(computer)
}
