Swift first look at pluralsight


* support legacy C and Objective-C

* swift  = targeted platform development language for apple

* swift is not:
	 c-based
	 scripting language
	 messaged based

* swift is strong typed

* swift can be integrated easility wiht objective-C


ch1. Swift Repl
#############################

1. check where are xcode's command tools are located 
MacBook-Pro:pynb zimine$ xcode-select -p
/Library/Developer/CommandLineTools

one can point to use command line tools of specific xcode version
$ sudo xcode-select -s /path/to/new/cmdlineTools 

2. to start a swift repl
$ xcrun swift
> :help
> :exit
> import Foundation
> let df = DateFormatter()
> df.dateStyle = .MediumStyle
>df.stringFromDate(NSDate())

put this statements in a file Formatter.swift

than run it as
$ xcrun swift Formatter.swift


ch2 Data types in Swift
###############################

how to see docs:
press Option button and hover a mouse over a type, then click. Doc appears in a popup window


Swift language

!! Type safety

core types: Classes Extensions Tuples Closures Protocols Structs Functions Enumerations

let   defines a Constant (immutable)
var defines a variables (mutable)

e.g array
var mutable = ["alpha", "bravo", "gamma"]
let immutable = ["alpha", "bravo", "gamma"]

Optionals
----------
	* is part of a type safety
	* any type can be defined optional
var name: String?
var job: String!
var city: String

varname!  is unwrapping a variable to access its value (should be non nil)


Value & Reference types
-----------------------

value types are linked to the  same memory cell
   an assignement makes a copy of the type's value
reference type can be switched to point to different memories cells
	an assignment does not make a new copy of the type's value

reference types :
	classes , functions 

value types : 
	structures, enumerations, tuples 


Reference types.classes
	* single inheritance model supported
	* support polymorphism
	* class & instance methods


 Functions 
-----------
 func say(phrase: String) -> Void {
    print ("saying loud.. \(phrase)")
}	

functions can have external and internal names (when a func calls another func)

func sayb(phrase str: String, times n: Int) { // 2 arguments with external and internal n
    for i in 0...n{ // _ is a counter variable which is never used
        say(phrase: str) //str is an internal name
    }
}

Closures
---------
example of a closure
let names = ["Al", "Ann", "Alex", "Alice", "Audrey", "Ax", "Axa"]
let filtered = names.filter() { $0.lengthOfBytes(using: String.Encoding.utf8) < 3 }
print(filtered)

//closure function
func isShortName(name:String) -> Bool{
    return name.lengthOfBytes(using: String.Encoding.utf8) < 4
}
print(names.filter(isShortName)) // envoking a function pointer



Methods
-------
are a special type of functions 

Enumerations
-------------

In swift enums are a rich type, allowing to define a behavior methods inside their definitions

Tuples
--------
a compound type 
example: http codes

var s1 = (code: 404, message: "note found")
s1.code
s1.message

Tupes & optionals 
(Int, String)
(Int?,String?)
(Int,String)?

Tuples are good for: 
	return values
	unneeded for func arguments
	short-lived, temporary data 
	more? use class or struct


Protocols
---------

are contracts (like interfaces)


Extensions
----------

add computed properties 

good way to package utility methods in a class



###############################
ch3  ObjectOriented Programming
###############################


ch3  Object-Oriented Programming in Swift 
	* class defnition similar  to java and c#
	* single interitance
	* methods
	* polymorphism throug protocosl
	* properties
	* extensions
	* object instances are references types

	objet creation
    let instance_var = ClassName()  # allocates pointer and memory

    init() is called for initialization, multiple init() can exist   equivalent of constructor
    designated initilizer canonical way to create an instance
    convenience initilizer

    in subclasses designated initilizer delegate up, convenience initilizers delegate across


   deinit()  method  to unregister an object
 
   xcrun swift deinitdemo

   deinit  is to be reviewed 

   properties
   ----------
   stored vs computed
   	stored just hold values
   	need to set or compute a value is a computed property

   	type vs instance types
   	class keyword for classes
   	static keyword for struct and enum

   	property observers  5_PropertyObservers
   		willSet()
   		didSet()

   	lazy  properties  6_LazyProperties
    6_Lazy_Properties

    overrinding
    -------------
    applied to:
	Methods
	Initilizers
	Computed properties

	final prevents overriding    

    trowing away instances
    p = nil  // # calls deinit()
   
    polymorphism
    !!! 9_Polymorphism.playground
    !!! 10_ValuePolymorphism.playground
    -------------
	operators:
		is
		as?  conditionally downcasts
		as   downcasts

    Memory Management
    ------------------
    Automated Reference Countring (ARC)
    circular references 
    !! xcrun swift mem_mgmt_classes.swift

    Generics
    ---------

    generics allow  to access elements of a collectio without having to
    downcast them

    struct Array<T> : MutableCollectionType, Sliceable {
    	var first: T? {get}
    	var last:  T? {get}

    	func filter(includeElement: (T)->Bool) -> [T]
    }

    type constraints in generics //Key
    struct Dictionary<Key : Hashable, Value> {

    }

    ! 11_Generics.playground

 ###############################  
 ch4 Swift Standard Library
 ###############################  
     	(apparently small)

    built in types 
    String,
    Int64, Int32, INt16, Int8, Int, UInt64, UInt32, UInt16, UInt8, Uint
    Optional<T>
    Array<T>
    Dictionary<T>
    Bool
    Double
    Float

    3 publicly documented protocol
    Equatable, Comparable, Printable

    only few global functions

    print(), sort(), sorted(), 

    swift leverages [Objective-C] objects

    core types
    --------

     Strings  !! 1_Strings.playground
     Numbers !!! 2_Numbers.playground    
     Arrays !!! 3_Arrays.playground
    
    Maps (Dictionaries)
    !! 4_Dictionaries.playground 


    Protocols 
    !! 5_Protocols 

    Sorting
    6_Sorting.playground


Using Objective-C 

id -> Any
NSString -> String
NSDictionary -> Dictionary
*  ->  ?   // pointers



###############################
ch4  Conclusion and overview
###############################

1. swift programming language 2 free books from apple 
in iBooks
in Xcode documentation

http://swiftdoc.org/
https://devforums.apple.com

swift  unexplained parts
------------------------
Access control 
flow-control
custom operators and operator ovrloading
interface builder 
Optional Chaining
Deeper Obj-C Interop. 








