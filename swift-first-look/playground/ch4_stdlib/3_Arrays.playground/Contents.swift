//: Playground - noun: a place where people can play

import UIKit


let names = ["Larry", "Moe", "Curly", "Bracy"]

// MARK: - Subscripts

names[0]
names[1]
//names[1.4]
//names[1.9]
names[2]
names[1..<3]
names[1...2]
names[0..<3]
names[1...1]
names[1..<1]


// MARK: - Append

// Can't append to an unmutable array (let)
//names.append("Shemp")

var colors = ["red", "green", "blue"]
colors.append("orange")
colors += ["purple"]
colors

//colors.append(UIColor.darkGrayColor()) // # only append a same type 

colors.insert("brown", at: 2)
colors

// replacing
colors[2] = "magenta"
colors

// MARK: - Remove

// Can't mutate a constant
//names.removeAtIndex(0)

colors.remove(at: 0)
colors

colors.remove(at: 3)
colors


//colors.removeRange(0...2) // not in swift3
//colors

colors.removeLast()
colors

//colors.removeAll()  // works in swift 3
//colors.capacity

colors.removeAll(keepingCapacity: true)
colors.capacity
colors

// MARK: - Capacity

colors = ["red", "blue", "green"]
colors.capacity
colors.isEmpty
colors.count

//colors.extend(["red", "green", "blue"])  // no in swift3


colors.reserveCapacity(10)
colors.count
colors.capacity

// MARK: - Sorting
colors.append("yellow")
colors.append("brown")

// `sorted()` returns a new array, it doesn't mutate it in-place
let sortedColors = colors.sorted() { $0 < $1 }
sortedColors

colors.sort() { $0 < $1 }
colors

// for unmutable array  use  .sorted()
names.sorted()
names // names is not changed


// MARK: - Reverse

// `reverse()` doesn't mutate the Array, it returns a new copy
colors
colors.reverse()


// MARK: - Filtering

let longColors = colors.filter(){ $0.lengthOfBytes(using: String.Encoding.utf8) > 4  }
longColors

let colorLenghts = colors.map() { $0.lengthOfBytes(using: String.Encoding.utf8)  }
colorLenghts

// MARK: - Map reducing concepts 

//# the old way
var totalCount = 0
for item in colorLenghts {
    totalCount += item
}
totalCount

// the closure way with mapreduce concepts 
let totalLength = colorLenghts.reduce(0){ $0 + $1 }
totalLength




// MARK: - Combining arrays

var moreColors = ["orange", "black", "purple"]
colors += moreColors
colors


//["<", ">"].join([colors, colors]) // not in swift3

// not in swift3
// Inserts elements of the given array at the given index
// colors.splice(["orange", "black", "purple"], atIndex: 1)
//colors








