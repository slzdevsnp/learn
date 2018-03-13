//: Playground - noun: a place where people can play

import UIKit

//neuburg 1  pp 70

var str = "Hello, playground"

//MARK: - closures

//a closure is a scope inside curly braces


// closures. This means they can capture references to external variables in scope
// within the body of the function.

class Dog {
    var whatThisDogSays = "woof"
    func bark(){
        print("this instance of Dog says \(self.whatThisDogSays)")  //refers to a variable outside
                                                                    //function's scope
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
print("##called on a Dog class")
d.bark()

let barkFunc = d.bark // assign to a variable

doThis(barkFunc)

d.whatThisDogSays = "miaou" //now change a class intance variable
doThis(barkFunc)  //this is visible when calling the func bark of this instance
doThis(d.bark)
//now lets see the difference with a struct ( value type
print("##called on a struct Dog2")
var d2 = Dog2()
d2.whatThisDogSays = "gav"
let barkFunc2 = d2.bark
doThis(barkFunc2)
d2.whatThisDogSays = "hryu"
doThis(barkFunc2) //gav . the old dog is still captures in the closure
doThis(d2.bark) // hryu because we are now fetching the new dog


//MARK how closures improve code //TODO !!

//MARK -  closure setting a captured variable

func pass100(_ f:(Int)->()){
    f(100)
}

print("## closure setting a captured variable")
var x = 0
print(x)
func setX(newX:Int){
    x = newX
}
pass100(setX) //pass100 reaches and changes the value of x variable defined outside
print(x)

//MARK -  Escaping closures

//@escaping is annotation to tell that the environment of the passed function is preserved for
// the later execution

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
print("#### escaping closures")
let countedGreet = countAdder(greet)
countedGreet() // each call returns a modified function
countedGreet() // in each call the environment is preserved
countedGreet()

let dudeGreet = countAdder({print("hey dude") })

dudeGreet()
dudeGreet()


//curried functions ??

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
print("#### func return a func with param")
let helloSlogan = actionMultiplier("hello world")
helloSlogan(2)

let aurevoirAction = actionMultiplier("Aurevoir!")
aurevoirAction(3)

//MARK: - function selectors  names with signatures (pp 62 )

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

print("##### function selector")
let b = Bear()
b.test() //?


// function refeerence scope
print("####function reference scope")

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

print("#### function reference scope")
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

