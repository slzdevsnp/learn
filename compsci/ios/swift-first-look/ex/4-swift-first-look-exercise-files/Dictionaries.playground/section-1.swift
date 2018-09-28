// Playground - noun: a place where people can play

import UIKit

var capitals = [
    "日本国": "東京都",
    "Italy": "Rome",
    "United States": "Washington D.C."
]

// MARK: - Subscript getting & setting

// subscript access returns an optional...
capitals["日本国"]
capitals["Kenya"]

// ...which means we can conditionally-unwrap the value
if let rome = capitals["Italy"] {
    println(rome)
}

capitals["United Kingdom"] = "London"
capitals

// MARK: - Updating

// mutating via `updateValue` returns the previous value
capitals.updateValue("Milan", forKey: "Italy")
capitals["Italy"]

capitals.updateValue("Rome", forKey: "Italy")

// Adding a new value returns `nil` as previous value
capitals.updateValue("Nairobi", forKey: "Kenya")
capitals["Kenya"]

// MARK: - Removing values

// returns removed value
capitals.removeValueForKey("United States")
capitals

// returns `nil` since the key "France" was never in the dictionary
capitals.removeValueForKey("France")

// MARK: - Count, Keys, Values

capitals.count

// .keys and .values return `MapCollectionView` instances. 
// Pass them to Array initializers to make arrays out of them
let keys = capitals.keys
let values = capitals.values

Array(keys)
Array(values)

// MARK: - Semantic Equality

capitals == [
    "日本国": "東京都",
    "Italy": "Rome",
    "United States": "Washington D.C."
]

var capitals2 = capitals
capitals == capitals2

capitals2.removeValueForKey("Italy")
capitals == capitals2
capitals != capitals2
