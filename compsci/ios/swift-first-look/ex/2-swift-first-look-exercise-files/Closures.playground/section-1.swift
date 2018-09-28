// Playground - noun: a place where people can play

import UIKit


let names = ["Al", "Ann", "Alex", "Alice", "Audrey"]

// Returns `true` if name < 4 bytes long (in UTF8)
func isShortName(name: String) -> Bool {
    return name.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) < 4
}

// Returns a closure that returns `true` if the
// length of the given string is less than `max`.
// This parameter defaults to 3 if not defined
func nameWithMaxLength(max: Int = 3) -> (String) -> Bool {
    return { (name: String) in
        return name.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) < max
    }
}

// In-line filtering with a closure
println(names.filter() { $0.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) < 3 })

// Filtering with a named function
println(names.filter(isShortName))

// Filtering with a generated function and parameter
println(names.filter(nameWithMaxLength(max: 4)))

// Filtering with a generated function (default value)
println(names.filter(nameWithMaxLength()))
