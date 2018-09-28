//: Playground - noun: a place where people can play

import Foundation

///MARK: - Access Controls

public class Super{
    public func doSome(){ }
}

public class Sub : Super {
    
    override public func doSome(){ }
   //override private func doSome(){ }  // compiler error

}

//another example  with an internal class defined

public  class MyClass{
    
    public func doSomething() {
        let worker = Helper(owner:self)
        worker.helpMe()
    }
    private func access(){ /*...*/ }
    
    //define a property with a private set method
    private (set)
    public var x: Int{ set{ /*..*/ } get{return 0}}
    
    //inner class
    private class Helper{
        
        private let owner:  MyClass
        private init(owner:MyClass){self.owner=owner}
        private func helpMe(){
            owner.access()
            owner.x = 0
        }
    }
    
    
}

///MARK :- Downcasting 

var p:Super = Sub()

if p is Sub {
    var s:Sub = p as! Sub
}

//a frequent case 
if let s2 = p  as? Sub{ /*  use s2 here */ }
//or a variant  which has an explicit syntax
guard let s2 = p as? Sub else { fatalError() }


///MARK: AnyObject  and Any  (two magic classes)

var obj:AnyObject = Sub()
let a0:[AnyObject]  = ["a", [0,1], Sub()]

for x in a0{
    if let a = x as? String {print("\(a)") }
    if let b = x as? [Int] {print("\(b[0])") }
    if let c = x as? Sub { print("Sub") }
}

let a1:[AnyObject] = ["aa", "bb", "cc"]
for s in a1 as! [String] {
    print(s)
}

// Any
class Customer{ var name = "Moe" }
var things: [Any] = [ 0, 42, 0.0, 3.14, "xyz", (1,2), Customer(), { (x:Int) -> Int in return x } ]

for thing in things {
    switch thing {
    case 0.0        as Double: print("double 0.0")
    case            is Double: print("some double")
    case 0          as Int:    print("0 int")
    case let i      as Int:    print("\(i)")
    case let s      as String: print("\(s)")
    case let (x,y)  as (Int, Int):  print("\(x), \(y) tuple")
    case let p      as Customer:    print("\(p.name)")
    case let f      as (Int)->Int:  print("\(f(0)) lambda")
    default:                        print("???")
    }
}

///MARK: - Generics

func mySwap<T>(inout a:T, inout _ b:T){  //look at inout keyword for params
 let tmp = a
 a = b
 b = tmp
}

var a: Int = 10, b:Int=20
mySwap(&a, &b)
a
b
var ax: String = "aa", bx:String="bb"
mySwap(&ax, &bx)
ax
bx

//generics with classes
class Person{}
class Employee : Person{
    func daysSinceLastVacation() -> Int {/*..*/ return 0 }
}

//a generic class
class PriorityQueue<ItemT, LevelT>{
    func add(_item item: ItemT, priorityLevel:LevelT) {/*..*/}
    func getHighestPriorityItem() -> ItemT?     {/*...*/ return nil }
}
//using it 
var nextVacation = PriorityQueue<Person, Int>()

func waitForVacation( p: Employee){
    nextVacation.add( _item:p, priorityLevel:p.daysSinceLastVacation() )
}

//using generics in enum 
enum Bounds <T>{
    case MIN(T)
    case MID(T)
    case MAX(T)
}

let min: Bounds<Int>
min = .MIN(0)

let dmin: Bounds<Double> = .MIN(0.0) //inline declaration and assignment

///MARK: - Extensions 

//extensions is a powerful idea,  when a new requirement comes in you don't have to redefine a class
//just add a new extension covering that requirement
// BUT: you cannot override an existing class method in extension
//      cannot put designated initializers in an extension
//      cannot add new cases of enum in its extension

extension String{  // this is not a sub class
    var length: Int { return self.characters.count }
}
let me = "Allen"
me.length

//extension work with Value types e.g. Double (struct) 

extension Double {
    var m: Double { return self }
    var km: Double { return self * 1_000 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self/3.2808 }
}

let oneMeter = 1.0.m // 1.0 
let oneInch = 25.4.mm
let threeFeet = 3.ft
let marathon = 42.km + 195.m

//lets extend an Array class 

extension Array {
    //provide a default value if element at specified index not present
    func elementAt( i: Int, defaultsTo:Element) -> Element {
        if (0..<count ~= i ){
            return self[i]
        }
        return defaultsTo
    }
}

let ar = [0,1,2]
let y = ar.elementAt(2, defaultsTo: -1) // expect 2
let z = ar.elementAt(3, defaultsTo: -1) // expect -1

//example of extending an Int struct with a closure, a bit dummy
extension Int{
    func times (task : ()->() ) {
       for _ in 0..<self{
       task()
}
    }
}

3.times{ print("hello") }

///MARK: -identity === operator  useful to check object equality


class MyXclass {
    var contentX = "a"
    var contentY = "b"
    /*..*/
    func isEqual (other: MyXclass? ) -> Bool {
        guard let   compareTo = other else { return false} // other is nil
        if          compareTo === self     { return true} // x.isEqual(x)
        return      contentX == compareTo.contentX && contentY == compareTo.contentY
    }
}

var ma = MyXclass()

var mb = MyXclass()

ma.isEqual(mb)
