//: Playground - noun: a place where people can play

import Foundation

///MARK:  value vs reference objects


var a = 0
var b = a

b = 10

func f (var a:Int){
    a = -1
    print("a in f: \(a)")
}

f(a)  // a is passed by value

print("a out of  f: \(a)")


struct Point { var x=0, y = 0}

var z = Point()
var y = z // making a copy of z
y.x = 10
func f(var a: Point){
        a.x = -1
}

f(z)
z
y
/// -> structs are value objects  but classes are reference objects

class CPoint { var x=0, y=0 }
var  i = CPoint()
var  j = i
j.x = 10
i // and j point to the same object

func f(var a: CPoint){
    a.x = -1
}

f(i) //calling a function changes i.  i is passed by a reference
i
j


//formal syntax for a class

class Circle{
        var center = Point()
        var radius  = 0.0
    init (c:Point, r:Double) { center = c; radius = r } //initializer
    deinit{ /*..*/} //when object is no longer referenced by the program the deinit will be called
                    //predicet behaviour
    
    //class and structs can have methods
     //final func moveTo  // can not be overrident by subclass
    func moveTo ( center: Point){
            self.center = center
    }
    
    //additional field with lazy initialization
    var  offset = Point()
    //lazy var offset = getDefault() // lazy initialization should have an initializer function
    func offset(here:Point){ self.offset = here }
    
    // class variable vs an instance one
    static var radius_incr = 1.0
    class func increment_radius(incr:Double){ radius_incr += incr } //class variable
        
}


class Node {
        
    var i = 9
    var optDict: [String:String]? //may be nill
    var next: Node?  //may be nill
    
    func successor() ->Node?{return next}
}

let obj = Node()
//optionals chain
//    if let a = obj.next?optDict?["k"]?.isEmpty { /*..*/ }

let optObj = obj.next  // implicitly optional

optObj?.successor() // no compile error .successor() is called only if objObj is not nill



///MARK: - Tuples



class HttpStatus {
    var description: String
    var code: Int
    init( _ code: Int,  _ description:String){
        self.code = code
        self.description = description
    }
    
}

let statii: [HttpStatus] = [HttpStatus(404, "Not Found"), HttpStatus(200, "Ok") ]


let http404Error = (404, "Not Found") // here is a tuple
http404Error.0
http404Error.1

let http200Error = (code: 200, description:"Page OK") // explicit declaration of fields

http200Error.code
http200Error.description

let (status,desc) = http404Error
print("\(status): \(desc)")

let (xstatus, _) = http404Error

print("\(xstatus)")


//example of a function return a tuple
func fetch() ->(code:Int, desc:String){
    return(200, "Okay")
}


let astatus = fetch()
astatus.code
astatus.desc

let (error, desciption) = fetch()
error
desciption

///MARK: - enums 

enum  CompassPoint {
    case North
    case South
    case East, West // can define several cases on 1 line
}

var  direction = CompassPoint.North //implicit declaration
direction = .South //compiler knows that direction is of type CompassPoint


switch direction{
case .East: print("East")
default:  print("Not East")
    
}

//enum can cary values

enum Postalcode {
    case US(Int, Int)
    case UK(String)
    case CA(code:String)
}

var somewhere = Postalcode.US(94707, 2624)

var someotherwhere = Postalcode.UK("SW1A 1AA")


var somehere = Postalcode.CA(code: "V5K 0A1")

switch somewhere {
    case .UK (let s): print("\(s)")
    case .US (let loc, var route): print("\(loc)-\(route)")
    case .CA: break;
}


//enum with raw type

enum ASCIIControls : Character {
    case Newline = "\n"
    case Carriage = "\r"
    case Tab      = "\t"
}


enum Planet: Int{
    case Mercury = 1,
         Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}
// for Venuts etc.  values  2,3,.. are supplied iplicitly

let x = Planet.Earth.rawValue

if let aPlanet = Planet(rawValue: 8){
    print ("\(aPlanet.rawValue)")
}


enum Dimension{
    case DISTANCE(Int)
    
    func value() -> Int{
        switch self{
            case .DISTANCE(let value): return value
        }
    }
}

let aDistance = Dimension.DISTANCE(10)
aDistance.value()


// enum to implement a state machine

enum ConnectionState{
    
    case closed
    case opening
    case open
    case closing
    
    mutating func next() {
        switch self{
        case closed: self = opening
        case opening: self = open
        case open:    self = closing
        case closing:  self = closed
        }
    }
}

var state = ConnectionState.closed
state.next() // opening
state.next() //open
state.next() //closing
state.next() //closed


