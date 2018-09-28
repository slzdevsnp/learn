// Playground - noun: a place where people can play

import UIKit

@objc protocol Tuneable {
    var pitch: Double { get }
    func tuneSharp()
    func tuneFlat()
    optional func transpose(hertz: Double)
}

class Guitar: Tuneable {
    
    var pitch: Double = 440
    
    func tuneSharp() {
        println("increasing string tension...")
        self.pitch += 5
    }
    
    func tuneFlat() {
        println("decreasing string tension...")
        self.pitch -= 5
    }
    
    func transpose(hertz: Double) {
        pitch += hertz
    }
}

class Saxophone: Tuneable {
    
    var pitch: Double = 440

    func tuneSharp() {
        println("pushing mouthpiece in...")
        self.pitch += 1
    }
    
    func tuneFlat() {
        println("pulling mouthpiece out...")
        self.pitch -= 1
    }
}


let guitar = Guitar()
let sax = Saxophone()
let instruments: [Tuneable] = [guitar, sax]

for i in instruments {
    i.tuneSharp()
    i.transpose?(20)
}

println("Guitar pitch: \(guitar.pitch), Sax pitch: \(sax.pitch)")

