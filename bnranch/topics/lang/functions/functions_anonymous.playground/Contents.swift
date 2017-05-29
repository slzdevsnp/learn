//: Playground - noun: a place where people can play

import UIKit

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


//MARK: - apply to arrays
let arr = [2,4,6,8,10]
print("== applics to arrays")
print("initial array \(arr)")

let arr2 = arr.map({
    (i:Int) -> Int  in
    return i*2
})
print("after transform:\(arr2)")

let arr3 = arr.map({$0*$0})
print("swiftier version \(arr3)")

//MARK: - define and call 

/*
 {
    // ... code goes here
 }()
 
 */


//MARK: - closures

// closures. This means they can capture references to external variables in scope
// within the body of the function.

class Dog {
    var whatThisDogSays = "woof"
    func bark(){
        print("this instance of Dog says \(self.whatThisDogSays)")
    }
}
struct Dog2 {
    var whatThisDogSays = "woof"
    func bark(){
        print("this instance of struct Dog says \(self.whatThisDogSays)")
    }
}

func doThis(_ f: () -> () ){  // f is of type () -> () ie. a func taking no params retuning void
    f()
}

print("#### closures")
var d = Dog()
d.bark()

let barkFunc = d.bark // assign to a variable

doThis(barkFunc)

d.whatThisDogSays = "miaou" //now change a class intance variable
doThis(barkFunc)  //this is visible when calling the func bark of this instance
doThis(d.bark)
//now lets see the difference with a struct ( value type
var d2 = Dog2()
d2.whatThisDogSays = "gav"
let barkFunc2 = d2.bark
doThis(barkFunc2)
d2.whatThisDogSays = "hryu"
doThis(barkFunc2) //gav . the old dog is still captures in the closure
doThis(d2.bark) // hryu because we are now fetching the new dog


// Escaping closures
/*
func funcPasser(f:()->()) -> () ->() { //compile error
    return f
}
*/
func funcPasser(f:@escaping ()->()) -> () ->() { //legal with @escaping
    return f
}

func countAdder(_ f: @escaping () ->() ) -> ()->() {
    var ct = 0
    return {
        ct = ct + 1
        print("count is \(ct)")
        f()
    }
}
func greet(){
    print("howdy")
}
let countedGreet = countAdder(greet)
countedGreet() // each call returns a modified function
countedGreet() // in each call the environment is preserved
countedGreet()

//curried functions

//we define a function which returns a function with a param Int
func actionMultiplier(_ s:String) -> (Int) ->() {
    print("multiplying actions")
    return {
     t  in
        for _ in 1...t {
            print("slogan: \(s)")
        }
    }
}

let helloSlogan = actionMultiplier("hello world")
helloSlogan(2)

let aurevoirAction = actionMultiplier("Aurevoir!")
aurevoirAction(3)

//MARK: - function selectors  names with signatures 

class Bear{
    func bark(){
        print("rrrr")
    }
    func bark(_ loudly:Bool){
        if(loudly){ print("RRRRR") }
        else{ self.bark() }
   }
    //overloaded function
    func bark(_ t:Int){
        
    }
    func test(){
        //self is used to explicitely specify a funtion reference scope
        //let voiceFunction = self.bark //compile error ambigous use
        let voiceFunction = self.bark as (Bool) -> ()   //loud voice
        let timesFunciton = self.bark as (Int) -> ()  //(_:) overloaded
        let quietVoiceFunc = self.bark as () -> () // explicit use of signature
    }
}


//b = Bear()
//b.test()


// function refeerence scope
print("function reference scope")

class Cat{
    func purr(){print("mourrr")}
}
class Mouse{
    func scream(){print("pi") }
    
    func test(){
        print("calling mouse test()")
        let screamFunction = self.scream //legal but not necessary
        let c = Cat()
        let purrFunction = c.purr // if you have instance of an object around
        
        screamFunction()
        purrFunction()
    }
}

let m = Mouse()
//m.scream()
m.test()


//MARK: - selectors

//@IBOutlet  var b: UIButton!  // @IBOutlet
/*
class ViewController : UIViewController {
    @IBOutlet var button : UIButton!
    func viewDidLoad() {
        super.viewDidLoad()
        self.b.addTarget(
            self, action: #selector(buttonPressed), for: .touchUpInside) // selector
    }
    func buttonPressed(_ sender: Any) {
        // ... }
}
*/
