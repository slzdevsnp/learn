Swift in Depth
by Allen Holub


based on swift 2.0  (xcode 7.3.1)

http://stackoverflow.com/questions/10335747/how-to-download-xcode-4-5-6-7-8-and-get-the-dmg-or-xip-file

(xcode 7.3)


############################################
ch1 Approach, Prerequisitories and Resources 
############################################

exercises  http://holub.com/swift   
-> swift compact reference
https://github.com/aholub/SwiftInDepth

ways to run swift code
 * repl
 * 




############################################
ch2 Operators, Tuypes, Collections
############################################

!! 1_Operations_Declarations_Strings.playground

!!_2_optionals.playground

!!! 3_Arrays_Sets_Dictionaries



############################################
ch3 Classes Structs basics,  tuples, enums
############################################

Struct is value type
Class is reference type

Struct is normally used as an immutable object 

mutating func() can be used to change the state of a struct object 

nested classes 

!!! 1_Struct_Class_Tuple_Enum.playground



############################################
ch4 control flows, patterns error handling
############################################

!!! 1_Controlflow_Patterns switches

!! 2_Asserts_Exceptions

assert(condition, "Message")  
	compiler -Onone #evaluates asserts (to be used in debugging)
	-O  #production mode , asserts are ignored
assertionFailure("Message")  


precondition(condition "Message") #always evaluated
precondition Failure("Message")

!! testAssert project 

guard keyword not well explained  compile errors on else {return}


############################################
ch5 functions and closures
############################################

!!! 1_Functions_Ref_functions.playground
!!! 2_Closures.playground

############################################
ch6 classes p1
############################################

functional vs object oriented
! 1_Subclass
!! 2_initializers

############################################
ch7 classes p2
############################################

access controls
permissions: file centri, not class centric
	public  : anybody can
	inernal : anybody in module/framework/app
	private : anybody in the same source file

best approach : one class definition per file

all fields should be private : rule of thumb
all helper methods should be private

!!! 1_casting_generics.playground

############################################
ch8 memory mgmt
############################################

swift uses a reference counting
!!! 1_memory

############################################
ch9 protocols
############################################

James Gosling  opinion: too much inheritance is bad, for abstraction contracts/protocols must be used

protocols contain mostly methods
!! 1_Protocols.playground

protocol extensions
!!! 2_ProtocolExtensions.plaground
/*
 * Agile:
 *  don't have to implement things I don't need now
 *  Do exactly what's required, and nothing more! 
 *  Don't need fake stab implementations to satisfy the protocol 
 *  Build only what's required
 */

############################################
ch10 Customizing Swift
############################################
 a demo with xcode project how to extend swift objects
 * subscripts
 * customize swift 
 * operator overloads
 * for/in integration (iterators)


 
