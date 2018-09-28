//neuburg  bk1 chap1

import UIKit

//MARK: - external names suppressed

//here s_ex is external name, s_in is intenal name
func echoString( s_ex s_in: String, times: Int) -> String {
    var result = ""
    for _ in 1...times { result += s_in }
    return result
}

//here internal and external name is the same
func echoString( s: String, times: Int) -> String {
    var result = ""
    for _ in 1...times { result += s }
    return result
}
//here external param anme is suppressed
func echoString(_ s: String, times: Int) -> String {
    var result = ""
    for _ in 1...times { result += s }
    return result
}


print("== external names")
print(" distinct ext, int names: \(echoString(s_ex: "hola", times:2))")
print(" same ext, int names: \(echoString(s: "helo", times:2))")
print(" suppresed ext name: \(echoString("ciao", times:2))")



//MARK: - overloading means same function names with different signatures
func say(_ what: String) {
    print ("said: \(what)")
}

func say(_ what: Int){
    let argStr = String(describing: what)
    print("said int version \(argStr) ")
}

//call funcs
print ("==overloading")
say("hello")

say(10)


//MARK: -  function default parameters 

class Dog {
    
    var name = ""
    private let voice = "wof"
    
    func say(times:Int = 1 ){
        for _ in 1...times{
            print(voice)
        }
    }
    
}
print("==default param")
let dog = Dog()
dog.say()
print("now with non default value")
dog.say(times: 3)


//MARK: - func with variadic variables 
func saywords(_ arrayOfStrings:String ...){
    for s in arrayOfStrings {
        print(s)
    }
}

print("==variadic")
saywords("hey", "hola")
saywords("hey", "hola", "bonjour", "privet", "ciao")


//MARK: - modifiable parameters 

// goal  change the input param by the function , (keyword inout)
func removeCharacter(_ c:Character, from s: inout String) -> Int {
    var howMany = 0
    while let ix = s.characters.index(of:c) {
        s.remove(at:ix)
        howMany += 1 }
    return howMany
}
print("== modifiable params")
var s = "hello world"
print("param  initially: \(s)")
let result = removeCharacter("l", from: &s) // &s means passing a ref
                                            // s String is a struct ie. value type
print("after removal happend \(result) times the param is: \(s)")

//instances of classes are modified in func without inout !!!
// this is a common pattern ie class intance variables are passed by ref
func changeName(of: Dog, name: String){
    of.name = name
}
let dd = Dog()
dd.name = "Ushka"
print("dog name: \(dd.name)")
changeName(of:dd, name:"Sharik")
print("dog name after change: \(dd.name)")


//MARK: - recursion
func countDownFrom(_ ix:Int){
    print(ix)
    if ix > 0 { // stopper
     countDownFrom(ix-1) //rcurse
    }
}

print("==recursion")
countDownFrom(3)

//MARK: - function as value

//this function takes another function as an argument
func doThis( _ f:() -> () ) {
    f()
}

func whatToDo(){
    print("I did it")
}
print ("== functons first class citizens")
doThis(whatToDo)
//in this call i define an anonymous function in the call
doThis( {var x = 1
        x += 1
        print(x)}
      )

//MARK: - anonymous functions

func doSteps(x: String, step:(_ ok:Bool) -> () ) {
    print("firstly printing \(x)")
    
    step(false) // i specify here a param to call the anon func
}

print("== anonumous functions")
doSteps(x:"hello world",
        step: {
            (ok:Bool) -> () in  //anonymous function's signature followed by in
                let x = 12
                print("next step: greetings \(x) times \(ok)")
              }
      )

