//: Playground - noun: a place where people can play

import UIKit

let cardsInDeck = 52

var (result, overflowed) = Int.addWithOverflow(12, 34)
result
overflowed

(result, overflowed) = Int.divideWithOverflow(22, 7)
result
overflowed

(result, overflowed) = Int.subtractWithOverflow(-128, 256)
result
overflowed


(result, overflowed) = Int.multiplyWithOverflow(123, 111)
result
overflowed



Int.max
Int.min

UInt.max
UInt.min


(result, overflowed) = Int.addWithOverflow(Int.max, 1)
result
overflowed


let count = UInt(32)
count.toUIntMax()
count.toIntMax()
count.toUIntMax()
count.toIntMax()
// deprecated in swift 3
//count.advancedBy(10)
//count.distanceTo(108)
//count.predecessor()
//count.successor()
//count.encode()

var (uResult, uOverflowed) = UInt.addWithOverflow(128, 256)
uResult
uOverflowed


// let count2 = UInt(-32) // # refused by compiler 


// MARK: - Doubles

let pi = 3.14159
let f_pi: Float = 3.14159
let ppi: Double = 3.141592

MemoryLayout.size(ofValue: pi)
MemoryLayout.size(ofValue: f_pi)
MemoryLayout.size(ofValue: ppi)


pi.isFinite
Double.infinity.isInfinite
pi.isNaN
// swift 3
//Double.NaN.isNaN
//Double.quietNaN.isNaN

pi.isNormal
//pi.isSignaling
//pi.isSignMinus
pi.isSubnormal
pi.isZero


//pi.encode()

Double.abs(2.3)
Double.abs(-2.3)





















