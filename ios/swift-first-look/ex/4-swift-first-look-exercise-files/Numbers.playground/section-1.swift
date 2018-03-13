// Playground - noun: a place where people can play

import UIKit

// MARK: - Int

let cardsInDeck = 52
cardsInDeck.predecessor()
cardsInDeck.successor()

cardsInDeck.advancedBy(10)
cardsInDeck

cardsInDeck.advancedBy(-20)
cardsInDeck

cardsInDeck.distanceTo(20)
cardsInDeck.distanceTo(cardsInDeck.successor())

var (result, overflowed) = Int.addWithOverflow(12, 34)
result
overflowed

(result, overflowed) = Int.divideWithOverflow(22, 7)
result
overflowed

(result, overflowed) = Int.subtractWithOverflow(-128, 256)
result
overflowed

Int.from(64)
Int.max
Int.min

// MARK: - UInt

let count = UInt(32)
count.toUIntMax()
count.toIntMax()
count.advancedBy(10)
count.distanceTo(108)
count.predecessor()
count.successor()
count.encode()

UInt.max
var (uResult, uOverflowed) = UInt.addWithOverflow(128, 256)
uResult
uOverflowed

// Compiler won't let you assign a negative value to a UInt* type
//let count2 = UInt(-32)

// Compiler won't let you create overflowed UInt instances
//let uIntOver = UInt8(32_767)

// MARK: - Doubles

let pi = 3.14159
let f_pi: Float = 3.14159

sizeofValue(pi)
sizeofValue(f_pi)

pi.advancedBy(1)
pi.advancedBy(-1.2)

pi.distanceTo(2.0)

pi.isFinite

pi.isInfinite
Double.infinity.isInfinite

pi.isNaN
Double.NaN.isNaN
Double.quietNaN.isNaN

pi.isNormal
pi.isSignaling
pi.isSignMinus
pi.isSubnormal
pi.isZero

pi.encode()

Double.abs(2.0)
Double.abs(-2.0)

Float.abs(2.0)
Float.abs(-2.0)