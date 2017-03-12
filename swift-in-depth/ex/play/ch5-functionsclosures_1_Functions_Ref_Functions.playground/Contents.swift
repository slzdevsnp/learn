//: Playground - noun: a place where people can play

import Foundation

func printName(first:String, last:String) ->()  //returns void, valid syntax but can be ommited
{
        print("\(first) \(last)")
}

printName("John", last:"Doe") //for a first argument an external name is _ so it ca be omitted

//external and internal names
func printName(given first:String, family last:String) ->()  //returns void, valid syntax but can be ommited
{
    print("\(first) \(last)")
}

printName(given:"Michael", family:"Jordan")  //using external names when calling a function
                                            //using internal names when calling a function inside a function


func printName(first:String, _ last:String) ->()  //returns void, valid syntax but can be ommited
{
    print("\(first) \(last)")
}

printName("Bob","Dylan")

//overloading

func myOverload(x:Int) { /*..*/ }
func myOverload(x:Int, y:Int) ->(Int,Int) { /*..*/ return (0,0) }
func myOverload(x:Double) ->Double { /*..*/ return 0.0 }

//but also overloading based on external names !!
func myOverload(a a:Int){/*..*/}
func myOverload(b b:Int){/*..*/}
func myOverload(c c:Int){/*..*/}

myOverload(a:10)
myOverload(b:10)

//fucs with tuples as args  + returning a nil
func findCenter(p1 start:(x:Int, y:Int), p2 end: (Int,Int))
                        -> (x:Int, y:Int)?{
    let (xEnd, yEnd) = end
    let xCenter = start.x + (xEnd - start.x) / 2
    let yCenter = start.y + (yEnd - start.y) / 2
    //lets if center is the same as start lets return a nil
    if xCenter == start.x && yCenter == start.y{ return nil }
    else { return (xCenter, yCenter) }
}

if let center = findCenter( p1:(1,1), p2:(5,5)) {
    print("center: \(center.x) , \(center.y)")
}
if let center = findCenter( p1:(1,1), p2:(1,1)) {
    //we do not access this code because center is nil
    print("center: \(center.x) , \(center.y)")
}
let b = findCenter( p1:(1,1), p2:(1,1)) // checking that findCenter returns a nil

//func params with default values
func sub(a a:Int=0, b:Int=0) -> Int { return b - a }
sub() //call with both defaults
sub(a:10)
sub(b:10)
sub(a:20,b:10)
sub(b:10,a:20) //if all arguments have external names you can change the order of arguments


///MARK: -variadic arguments, function references

func sum(numbers: Int...)->Int{
    var total = 0
    for number in numbers { total += number }
    return total
}

sum(1,2,3)
sum(1,2,3,4,5,6)

func sum( var total:Int = 0, numbers: Int...)->Int{
    for number in numbers { total += number }
    return total
}

sum(1, numbers: 2,3,4)


//inout arguments (covered somewhat in tupes
func swap (inout a:Int, inout _ b: Int){
    let t = a ; a = b ; b = t
}

var left = "L"
var right = "R"
swap (&left, &right) //& is not a reference operator like in C
left
right

//way to avoid using inout 
enum Status { case success, failure }

func doSomething() -> (status:Status, result:String){
    return(.success, "newValue");
}

doSomething()
///MARK: func references 
// functions are first class objects (i.e. new types )

func sayHello() { print("hello") }
func sayWorld() { print("to all the world") }

var talk = sayHello
var ttalk: () ->() = sayHello //explicit declaration
talk()
ttalk()

func speak ( f:()->() ){
    f()
}

speak(sayHello)
speak(sayWorld)


//a function which returns a function 

func moveTowardsZero( value: Int )
    -> (Int)->(Int) //returns a func which has an Int param and returns an Int
{
    func up (input:Int) -> Int { return input + 1 }
    func dn (input:Int) -> Int {return input - 1 }
    return( value < 0 ? up: dn)
}

var i = 5
let mover = moveTowardsZero(i)
var cn = mover(i)

for  k in 1...3{
    i = mover(i)
    print("\(i)")
}






