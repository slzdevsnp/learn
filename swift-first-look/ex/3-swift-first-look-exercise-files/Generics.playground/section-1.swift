// Playground - noun: a place where people can play

import UIKit

extension Array {
    // A poor-man's implementation of Array's built-in `map` method
    func pl_map<U>(transform: (T) -> U) -> [U] {
        var transformed = Array<U>()
        for item in self {
            transformed.append(transform(item))
        }
        return transformed
    }
}

let names = ["Alice", "Bob", "Carol"]
println(names.pl_map() { (name: String) in
    name.uppercaseString
})

println(names.pl_map(){ (name: String) in
    name.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
})

let numbers = [1, 2, 3, 4]
println(numbers.pl_map() { $0 * $0 })
