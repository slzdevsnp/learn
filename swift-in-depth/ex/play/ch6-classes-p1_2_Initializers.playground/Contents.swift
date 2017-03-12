//: Playground - noun: a place where people can play

import Foundation

///MARK: - initializers

class MyClass {
    var x:Int?  //an optional declared are always initialized to nil
    let const:Int = 10 //constants are better assigned  at the declaration line
    
    init() { print("init()") } // a trivial initializer
    init(x:Int){ self.x = x ; print("init(_)") }
    init(y:Int){self.x = y ; print("init(y)")}
    
    deinit { print("destroying MyClass") }
}

var a = MyClass()
a
var b = MyClass(x:100)
b
var c = MyClass(y:-11)
c

class Super {
    
    var d: Double
    init(d:Double) { self.d = d }  //designated (can have only 1 designated initilizer
    
    convenience init(i: Int) { self.init(d:Double(i)) } // 1st convenience  is chained to designated
    
    convenience init() {  self.init(i:0) }  // 2nd convenience is chained to first convenience
    //convenience init() {  self.init(d:0.0) } 2nd convenience can also chain directly to designated
}


var  zs = Super(d:5.5) //disignated called
var zi  = Super(i:4)  // convenience 1st called
var zn = Super()  //convenience 2nd called

// in derived classes
class Sub : Super{
    
    override init(d:Double){
        super.init(d:d)   // designated in sub must chain to designated in parent
    }                     //  ==>>  rule: Designated chains up
    
    convenience init(){   // convenience in sub  can chain only to designated  in sub or other
        self.init(d: 0.0) // convenience in sub
    }                     // ==>> rule: Convenience chains  across  (on the same level

    convenience init(i:Int){  // 2nd covenience chains to designated in sub
        self.init(d:Double(i))
        //super.init(i:i)  //compiler error
    }
    
}

class Subb : Super{
    //if no initializers defined in sub class,  all designated and convenience initializers are inherited from parent
}

var xs = Subb()
var xy = Subb(d:-4.67)

///MARK: initializations phases 

class XSuper {
    var i: Int
    init(i:Int){self.i = i } //designated
}

func g(s:XSub)->(){} //global func

class XSub : XSuper {
    var j: Int
    func f(){}
    
    init(j:Int){
      //  i = 0 ; f(); g(self) compiler error because i, g() access befor a call to super.init()
        self.j = j
        print("\(self.j)")
        super.init(i:j) // a call to initialize a parent class 
        i = 0; f(); g(self)  // valid in a phase after a parent class been initialized
    }
    
}

///MARK: - Circular references  (they are sometimes necessary)

class Company {
    var engineering: Department? //initialized to nil
    init(){
        engineering = Department(ofCompany:self)
        engineering!.f(self)
    }
    func g(){ /* Dangerous */ }
    
}

class Department{
    
    unowned let ofCompany: Company  // unowned is a reference to a Company
    
    init(ofCompany:Company){
        self.ofCompany =  ofCompany
    }
    
    func f(c:Company){
        ofCompany.g() //call of g() func is dangerous because no guarantee that Company had been put in expected state
    }
}

var zc = Company()

var zd = Department(ofCompany:zc)



///MARK: - Failable initializers

struct Failable {
    var istr:String
    init?(_ x:String){
        if x.isEmpty { return nil }
        istr = x
    }
}

let  fs1 = Failable("hello")
fs1?.istr
if let fs2  = Failable(""){
    print (" accessing safely \(fs2.istr)")
}


enum DistanceUnit: String {
    case Feed="ft"
    case Meters = "m"
}

if let unit = DistanceUnit(rawValue:"cm") { print("unit in cm")  }  //safely accessing a nillable DistanceUnit
else if let unit = DistanceUnit(rawValue:"ft") { print("unit in feet")  }


enum TempUnit{
    case Celcius, Fahrenheit
    init?(_ symbol:Character){
        switch symbol {
        case "C" : self = .Celcius
        case "F" : self = .Fahrenheit
        default: return nil
        }
    }
}

var tUnit = TempUnit("U")
tUnit //expecte to be nill

if let unit = TempUnit("C") { print("temperature in Celcius units") }






