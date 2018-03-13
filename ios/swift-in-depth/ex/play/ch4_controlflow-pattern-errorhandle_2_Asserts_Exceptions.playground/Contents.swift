//: Playground - noun: a place where people can play

import Foundation

///MARK: Asserts

//assert(condition, "Message")
//compiler -Onone #evaluates asserts (to be used in debugging)
//-O  #production mode , asserts are ignored
//assertionFailure("Message")
//
//precondition(condition "Message") #always evaluated
//precondition Failure("Message")

//fatalError("Message")

//testing an assert
print("hello world")
//assert(false, "somtething is wrong!") // runtime error
assert(true, "somtething is ok!") // asserts evaluates fine
print("AFTER")

///MARK: Exceptions 

class MyFile{
    
    //enum of error cases
    enum Error: ErrorType { case NoSuchFile(String), NotOpen }
    
    //initializer which throws an exception
    init( _ path:String) throws{
        if !MyFile.exists(path){
            throw Error.NoSuchFile(path)
        }
    }
    
    //member which throws an exception
    func readLine() throws -> String{
        if !isOpen { throw Error.NotOpen } //if exception is thrown  no String is returned fro a func
        return "A Line"
    }
    var isOpen = false
    class func exists(path:String) -> Bool{return true} //dummy
    func close() { /*..*/ }
    func length() ->Int { return 0 }
}

//catching exceptions, use of try
func doSomething(x:Int?){
    
    assert (MyFile.exists("/tmp/config.txt"))
    let aFile = try! MyFile("/tmp/config.txt") // try is used because Myfile.init() throws an exception
    defer{ aFile.close() }  // defer block is always executed (exception was raised or not

    do {
        let theFile = try MyFile("/tmp/config.txt")
        defer { theFile.close() }
        try theFile.readLine() // readLine() throws an excpetion
    }
    catch  let MyFile.Error.NoSuchFile(path)  {
        print("\(path)")
    }
    catch{ /*...*/ }  // a catch list should be excaused
}

// guard keyword

var optX: Int? = 10, optY: Int? = nil

//guard let x = optX, max=optY where 0 < x && x < max else {return}  // {return} ?

let optionalReturn = doSomething(optX)
//guard let o = optionalReturn else { return } //?





