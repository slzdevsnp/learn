//: Playground - noun: a place where people can play

import UIKit

let names = ["Al", "Ann", "Alex", "Alice", "Audrey", "Ax", "Axa"]

//closure
let filtered = names.filter() { $0.lengthOfBytes(using: String.Encoding.utf8) < 3 }
print(filtered)

func isShortName(name:String) -> Bool{
    return name.lengthOfBytes(using: String.Encoding.utf8) < 4
}
print(names.filter(isShortName)) // envoking a function pointer

// filter with a filter length as a parameter
func nameWithMaxLength(max: Int = 3) -> (String) -> Bool {
    return { (name: String) in
        return name.lengthOfBytes(using: String.Encoding.utf8) < max
    }
}

print(names.filter(nameWithMaxLength(max: 5))) // envoke func ptr with a param
print(names.filter(nameWithMaxLength())) // envoke a func ptr with a default param




