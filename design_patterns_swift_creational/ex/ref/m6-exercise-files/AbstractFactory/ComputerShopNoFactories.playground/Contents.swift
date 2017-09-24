//: Abstract Factory
//: > This demo illustrates the problem that is solved by the Abstract Factory pattern
import UIKit

struct Computer: CustomStringConvertible {
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
    
    public var description: String {
        return "\nYour configuration: \(finish) \(storage) \(processor) \(memory) \nTotal: $\(price)"
    }
}

//:### Create Computer instances
let basicComputer = Computer(finish: WhiteFinish(), storage: SmallHardDisk(), processor: BasicProcessor(), memory: BasicMemory())
print(basicComputer)

let officeComputer = Computer(finish: WhiteFinish(), storage: MediumHardDisk(), processor: FastProcessor(), memory: AdvancedMemory())
print(officeComputer)

let highEndComputer = Computer(finish: BlackFinish(), storage: HugeFlash(), processor: HighEndProcessor(), memory: ProMemory())
print(highEndComputer)

