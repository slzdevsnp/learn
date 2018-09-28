//: Playground - noun: a place where people can play

import UIKit

var capitals = [
    "日本国": "東京都",
    "Italy": "Rome",
    "United States": "Washington D.C."
]

// MARK: - Subscript getting & setting

// subscript access returns an optional...
// full access to utf character set
capitals["日本国"]
capitals["Kenya"]

if let rome = capitals["Italy"]{
    print(rome)
}


capitals["United Kingdom"] = "London"
capitals

// MARK: - Updating

// mutating via `updateValue` returns the previous value
capitals.updateValue("Milan", forKey: "Italy")
capitals["Italy"]
// mutating via `updateValue` returns the previous value
capitals.updateValue("Rome", forKey: "Italy")
capitals["Italy"]


// Adding a new value returns `nil` as previous value and works
capitals.updateValue("Nairobi", forKey: "Kenya")
capitals["Kenya"]

// returns removed value
capitals.removeValue(forKey: "United States")
capitals

// returns `nil` since the key "France" was never in the dictionary
capitals.removeValue(forKey: "France")

capitals.count

let keys = capitals.keys
let values = capitals.values

Array(keys)
Array(values)

var capitals2 = capitals

capitals == capitals2

capitals2.removeValue(forKey: "Italy")
capitals != capitals2







