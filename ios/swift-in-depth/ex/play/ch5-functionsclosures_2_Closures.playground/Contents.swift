//: Playground - noun: a place where people can play

import Foundation

func toDouble (x:Int) -> Double{ return Double(x) }

toDouble(5)



let lambdaDbl :  (Int) -> Double = { Double($0) } // defined a type without a function name

lambdaDbl(-1)

let powerTwo : (Double) -> Double = {$0 * $0 }

powerTwo(2)
powerTwo(-3)



//implemnenting a sorting  on array
var names = [ "Fred", "Wilma", "Barney", "Betty"]

names.sort()

//specialized sorting
let sorted1 = names.sort(  { (s1:String,s2:String)->Bool  in return s1 < s2  } )
sorted1
//using arguments positioning $0, $1  // you mast
let sorted2 = names.sort( { $0 < $1 } ) // ascending  $0 > $1 will be descending
sorted2

let sorted3 = names.sort{ $0 < $1 }
sorted3

//a function which returns a closure
func adder(increment:Int) ->(Int) ->Int{
    return { increment + $0 } // observe curly brackets in return statememnt
}                             //adder is a manufactor of a closure function

var add = adder(10)
var r: Int
add(0)
add(20)
add(5) // initial increment 10 is stored in a capture object

var addalt = adder(100)
addalt(0)
addalt(11)
addalt(21)

//func adder replaces a class with the same functionality
class Adder{
    var increment: Int
    init(_ increment:Int){
        self.increment = increment
    }
    func add(value:Int) -> Int {
        return increment + value
    }
}
var  theAdder = Adder(10)
theAdder.add(20) //returns 30

//a more complex example ; a function returns a tuple of two closures

//func getIncrementers(amount:Int) -> ( ()->Int,()->Int ) { //syntax with no names also words
func getIncrementers(amount:Int) -> ( incr:()->Int, deincr:()->Int ) {

    var total = 0
    return ( {total += amount; return total},
             {total -= amount; return total} )
}

let (up5,down5) = getIncrementers(5)
up5() //5
up5() //10
down5() //5
down5() //0
down5() //-5

// up5 and down5 share the state of an internal variable amount in a capture object

let (up1,down1) = getIncrementers(1)
up5() //0  0 +5
up1() //1
up5() //5
up1() //2


/// MARK: filter, map and reduce very useful methods for any collection object 
let letters = ["a", "b", "c"]
let toUp = letters.map{$0.uppercaseString}
toUp
let xsorted = letters.sort{$1 < $0}
xsorted
let filtered = letters.filter{$0 <= "c"}
filtered
let condense = letters.reduce("z"){$0 + $1}
condense

// a more complicated   real life a la db manipulation example . successive calls  of lambda funcs
// a lot of work donw with a minimal amount of work
var pnames = ["Fred Flintstone", "Wilma Flintstone", "Barney Rubble", "Betty Ruble", "Ivan Flintstone"]

let result =  pnames.filter{$0.hasSuffix(" Flintstone")}
    .map{$0.substringToIndex($0.endIndex.advancedBy(-11))}
    .reduce(""){ let sep = $0.characters.count > 0 ? ", ":"" ; return "\($0)\(sep)\($1)" }

result

///MARK:  - Currying  technique (adavnced )

func add (a:Int, b:Int) -> Int{ return a + b }  // normal function 

func add2 (a:Int) -> (b:Int) -> Int {
    return { (b:Int) -> Int in return a + b } // returns a closure
}
add2(1)(b:2) // the way to call multiple arguments sequentially , one pargument per ()

//func add2simpler (a: Int) (b: Int) -> Int { //  curried declaration are to be removed in future swift ?
//    return { b in a + b }
//}

func appender(delimiter: String) -> (String) -> String{
    var buffer = ""
    return { buffer += $0 + delimiter
            return buffer
    }
}

let append = appender(" ") // fixing delimeter
                           //do not need to carry a delimeter specified at each call of append()

append("Hello")
append("world")
append("!")
print( append("") ) // prints access of a current state of buffer 


//func appender2(delimiter: String, var buffer: String="")(suffix:String) -> String {
//        buffer += suffix + delimiter
//        return buffer
//}




