//: Playground - noun: a place where people can play

import Foundation

///MARK: - simple protocol example

enum Format { case XML, JSON}
protocol Representable {

    func representation( asType: Format) -> String
    init(asType: Format, contents:String)
}


class Employee : Representable {
    private var name: String = "Fred" //default value
    
    //impementing a function from a protocol
    func representation( asType: Format) -> String {
        switch asType {
        case .XML:	return "<employee name=\"\(self.name)\"/>"
        case.JSON:  return "\"employee\":{\"name\":\(self.name)}"
        }
    }
    required init(asType:Format, contents:String){ /*...*/  }
    init (name:String) { self.name = name }

}

//global function   //works on any object which implements Representable protocol
func doSomething (x: Representable){
    print("\(x.representation(.XML))")
}

var e = Employee(name:"Ivan")
e.representation(Format.JSON)
e.representation(Format.XML)

doSomething(e)

// more interesting example 

protocol Cacheable0 {
    func flush()
}

class CacheableEmployee0: Employee, Cacheable0 { // you can list only 1 class coming first and many protocols
    func flush() {
        /*...*/
    }
}
func doSomething1 (x:  protocol<Representable,Cacheable0>){  // func arugment implements 2 protocols
    print("\(x.representation(.XML))")
    x.flush()
}

doSomething1( CacheableEmployee0(name: "Fred"))

///MARK: - protocol which implements a protocol

protocol Cacheable : Representable {
    
    static var versionID: Double { get set }
    var 	   objectID: 	String { get }
    init()
    func  			flush 		()  -> String
    mutating func 	load 		(flushId:String)
    static func 	setTargets	(to: NSOutputStream, from:NSInputStream)
    
}

class CacheableEmployee: Employee, Cacheable {  //needs to implmement all methods in protocols Cacheable and Representable
    static var versionID = 1.2
    static var idPool 	 = 0
    let 		myId 	= ++idPool
    var objectID: String { return "CacheableEmployee"+"-\(CacheableEmployee.versionID)"+"-\(myId)"}
    required init(){
        super.init(asType:Format.JSON, contents:"")
    }
    required init(asType:Format, contents:String){
        super.init(asType:asType, contents:contents)
    }
    override init           (name:String){
        super.init(name:name)
    }
    func 	 	load 		(flushId:String){ /*....*/ }
    func 		flush 		() -> String 	{ /*..*/ return objectID }
    static func setTargets	(to:NSOutputStream,from:NSInputStream){/*..*/}
}


var cs1 = CacheableEmployee(name:"Peter")
var cs2 = CacheableEmployee(name:"John")
cs2.representation(.XML)

///MARK: -Protocols in generic classes

protocol Cloneable{
    func clone()
}
protocol Printable{
    func printing()
}
class SomeClass<T: Cloneable>{
    func clone(){}
}
class SomeOtherClass<T where T:Cloneable, T:Printable>{
    func clone(){}
    func printing(){}
}

///MARK: - Casting to protocols
protocol MyProtocol { func f() }
class AdoptingClass : MyProtocol { func f(){} }
let protocolRef : MyProtocol = AdoptingClass()

let protocolRef1 = AdoptingClass() as MyProtocol

///MARK: - self in protocols 
protocol SupportsReplace {
    func replaceWith(other: Self)
}

class ReplaceableEmployee: Employee, SupportsReplace {
    func replaceWith( other: ReplaceableEmployee) {
        name = other.name
    }
}

func overwrite<T:SupportsReplace > (original:T, with: T){
    original.replaceWith (with)
}

let fred = ReplaceableEmployee(name:"Fred")
let barney = ReplaceableEmployee(name:"Barney")
overwrite(fred, with: barney)

fred

protocol CCloneable: class {
    func clone() -> CCloneable
}


final class CloneableEmployee: Employee, CCloneable {
    func clone() -> CCloneable {
        return CloneableEmployee(name: self.name)
    }
}

let cef = CloneableEmployee(name: "Fred")

let ces = cef.clone()


///MARK: protocol generics
protocol Container {
    associatedtype T
    mutating func append(item: T)
}

class Queue : Container {
    var data: [String] = []
    //associatedtype T is resolved from  the definition of the append func
    func append(item: String) { data.append(item)}
}

var q = Queue()
q.append("Hola")
q.append("mama!")




///MARK: objective-C protocols 
// import Foundation should be imported

@objc enum ObjcEnum: Int { case X,Y}

protocol SwiftProtocol {/*....*/}

@objc protocol ObjcProtocol {
    func f (x: Int)
}

class ObjcClass : ObjcProtocol {
    @objc func f( x: Int){}  //observe that @objc is in front of all functions specified in @objc protocol
}

class ObjcSubclass: NSObject, ObjcProtocol {
    func f( x: Int) {}
}

///MARK: Optional Members

@objc protocol hasOptionalMembers{
    optional var optVar:Int {get}
    optional func optMethod()->Int  // this meethod can or can not be implemented in a supporting class
    func doSomething()  // this method must be implemented
}

class MyClass: NSObject, hasOptionalMembers {
    var optVar: Int { return 0}
    //func optMethod() -> {return 0} //choosed not to implment it
    func doSomething()->() {}
}

let opt:hasOptionalMembers = MyClass()
if let result1 		= opt.optMethod?() {/*..enters only if result1 != nil .*/} //if optMethod is not defined it resolves to nil
if let v1 			= opt.optVar  {/*...*/}

let v2: Int! 		= opt.optVar // live dagerously if optVar is nil, the program crashes






