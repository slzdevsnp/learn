//: Playground - noun: a place where people can play

import UIKit

//like interfaces or contracts
@objc protocol Tuneable {
    var pitch: Double { get }
    func tuneSharp()
    func tuneFlat()
    @objc optional func transpose(hertz: Double)
}

//classes implementing tunable
class Guitar: Tuneable {
    
    var pitch: Double = 440
    
    func tuneSharp() {
        print("increasing string tension...")
        self.pitch += 5
    }
    
    func tuneFlat() {
        print("decreasing string tension...")
        self.pitch -= 5
    }
    
    func transpose(hertz: Double) {
        print ("transaposing a guitar by \(hertz)")
        pitch += hertz
    }
}

class Saxophone: Tuneable {
    
    var pitch: Double = 440
    
    func tuneSharp() {
        print("pushing mouthpiece in...")
        self.pitch += 1
    }
    
    func tuneFlat() {
        print("pulling mouthpiece out...")
        self.pitch -= 1
    }
}


let guitar = Guitar()
let sax = Saxophone()
let instruments: [Tuneable] = [guitar, sax]

for i in instruments {
    i.tuneSharp()
    i.transpose?(hertz:21)
}

print("Guitar pitch: \(guitar.pitch), Sax pitch: \(sax.pitch)")


