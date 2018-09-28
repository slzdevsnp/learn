//: Playground - noun: a place where people can play

import UIKit

//extension Array{
    // lame reimplementation of array's build in `map` method
    //swift 3 needs T type to be declared
//    func pl_map<U>(transform: (T) -> U) -> [U]{
//        var transformed = Array<U>()
//        for item in self {
//            transform.append(transform(item))
//        }
//    }
//}


let names = ["Alice", "Bob", "Carol"]
// # use of a closure map()
print(names.map() { (name: String) in
    name.uppercased()
})

print(names.map() {(name: String) in name.lengthOfBytes(using: String.Encoding.utf8) }  )

let numbers = [1,2,3,4,5, 60]
print(numbers.map(){ $0 * $0} )
