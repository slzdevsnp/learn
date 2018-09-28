//: Playground - noun: a place where people can play

import Foundation

///MARK: - Protocol Extensions

protocol TextRepresentable{
    func asText() -> String
}

class Person{
    /*...*/
}

extension Person: TextRepresentable {  // a way to extend classes with contracts without modifing the class definition
    func asText() -> String {return "Aliluia"}
}


// a more interesting example
public protocol MyCollection{
    associatedtype  T
    init ( _ args:T...)
    func elements() -> [T]
}

public class IntCollection: MyCollection{
    private var contents: [Int] = []
    public required init (_ args: Int...){
        for i in args{ contents.append(i) }
    }
    public func elements() -> [Int] { return contents}
    
}

var myintbag = IntCollection(1,2,3,4,5)
myintbag.elements()


//lets extend  the Protocol when needed. !!!!! very important feature for agile developement !!!!
public extension MyCollection where T: SignedIntegerType {
    public func sum() -> T {
        var total: T = 0
        for e in elements() {  total += e }
        return total
    }
}

myintbag.sum()

public class StringCollection: MyCollection{
    private var contents: [String] = []
    public required init (_ args: String...){
        for i in args{ contents.append(i) }
    }
    public func elements() -> [String] { return contents}
    
}


var mystrbag = StringCollection("a", "b", "c")
//mystrbag.sum() // sum() member is not available


/*
 * Agile:
 *  don't have to implement things I don't need now
 *  Do exactly what's required, and nothing more! 
 *  Don't need fake stab implementations to satisfy the protocol 
 *  Build only what's required
 */

