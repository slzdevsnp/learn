// Playground - noun: a place where people can play

import UIKit

let names = ["Larry", "Moe", "Curly"]

// MARK: - Subscripts

names[0]
names[1]
names[1.4]
names[1.9]
names[2]
names[1..<3]
names[1...2]
names[0..<3]
names[1...1]
names[1..<1]

// Outside of array boundaries. Kaboom!
//names[-1]
//names[3]

// MARK: - Append

// Can't append to an array constant
//names.append("Shemp")

var colors = ["red", "green", "blue"]
colors.append("orange")
colors += ["purple"]
colors

// Can't do this since the array's generic type is inferred as String
//colors.append(UIColor.darkGrayColor())

// MARK: - Insert

// Can't mutate a constant
//names.insert("Shemp", atIndex: 2)

colors.insert("brown", atIndex: 2)
colors

// Can't do these. Invalid index specified
//colors.insert("chartreuse", atIndex: -1)
//colors.insert("yellow", atIndex: 32)

colors[2] = "magenta"
colors

// MARK: - Remove

// Can't mutate a constant
//names.removeAtIndex(0)

colors.removeAtIndex(0)
colors

colors.removeAtIndex(3)
colors

// Can't do these. Index is out of bounds
//colors.removeAtIndex(-1)
//colors.removeAtIndex(10)

colors.removeRange(0...2)
colors

// Can't do this. Range is out of bounds
//colors.removeRange(0...2)

colors.removeLast()
colors

colors.append("red")
colors.append("green")
colors.append("blue")
colors

//colors.removeAll()
colors.removeAll(keepCapacity: true)
colors.capacity
colors

// MARK: - Capacity

colors.capacity
colors.isEmpty

colors.extend(["red", "green", "blue"])
colors.capacity
colors.count
colors.isEmpty

colors.reserveCapacity(10)
colors.count
colors.capacity

colors.reserveCapacity(2)
colors
colors.count
colors.capacity

// MARK: - Sorting

// `sorted()` returns a new array, it doesn't mutate it in-place
let sortedColors = colors.sorted() { $0 < $1 }
sortedColors

colors.sort() { $0 < $1 }
colors

// MARK: - Reverse

// `reverse()` doesn't mutate the Array, it returns a new copy
colors.reverse()
colors

// MARK: - Filtering

// Filtering returns all elements that match, not just the first one it finds
let longColors = colors.filter() { $0.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 3 }
longColors

let noMatches = colors.filter() { $0 == "purple" }
noMatches

// MARK: - Map & Reduce

let colorLengths = colors.map() { $0.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) }
colorLengths

// The long-hand way to declare closures
//let totalLength = colorLengths.reduce(0, combine: { (a: Int, b: Int) -> Int in
//    a + b
//})

// The iterative approach
var totalCount = 0
for length in colorLengths {
    totalCount += length
}
totalCount

// The short-hand equivalent
let totalLength = colorLengths.reduce(0) { $0 + $1 }
totalLength

// MARK: - Combining arrays

var moreColors = ["orange", "black", "purple"]
moreColors += colors
moreColors

// Can't do this because `moreColors` is type Array<String>, not Array<UIColor>
//moreColors += [UIColor.orangeColor(), UIColor.blackColor(), UIColor.purpleColor()]

let evenMoreColors = ["turquoise", "green", "yellow"]
// Can't do this since `evenMoreColors` is declared as a constant
//evenMoreColors += colors

// MARK: - Undocumented initializers

let chars = Array("Alex")

// MARK: - Undocumented methods

["<", ">"].join([colors, colors])

// Inserts elements of the given array at the given index
colors.splice(["orange", "black", "purple"], atIndex: 1)
colors

