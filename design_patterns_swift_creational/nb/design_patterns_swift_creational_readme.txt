Design patterns in swift  creational
auth: Karoly Nyisztor 
www.leakka.com

Based on swift 3 

uses staruml 2 software  for uml diagrams

part 1 covers

{Singleton, Prototype, Factory Method, Builder,Abstract Factory }


####################
chap1
####################

the gang of Four

Erich Gamma, Richard Helm, Ralph Johnson, John Vlissides 

Design pattterns values and limitations
	Advantages:
		* proven solutions to specific recurring problems 
		* reusable 

	limitations:
		* can be too generics
		* expertise required to implement correctly

 -----------------------
| Categories of patterns
 -----------------------
 * Creational Patterns
    . separate object's creation from its usage
 	. hide the details of creational logic
 		- insert dependencies from the outside (dependency injection)
 	. allows for better unit testing
 	 	
 * Structural Patterns 
 	. define and manage relationships between objects in an application
 	. provide ways to compose objects in order ot obtain a new functionality

 * Behavioral Patterns 
    . how objects communicate between one another


## uml Primer 

- Class Diagrams
- Uml  Relations
- Sequence Diagrams 


*** Class Diagrams 
	shows names , attributes and operations, (methods) of an object

visibility ( + public, # protected, - private)

-----------
| Person   |
-----------
| + height |
| # age    |
-----------
| + talk() |
| - sleep()|
-----------


** Generalisation

 --------        --------
| Parent | <|--  | Child  |
 --------        --------

hollow triangle: parent has 1 or more derived classes 

** Association.  Class A  must reference Class B

-----------
| Course   |
-----------
    |1
    |
    |0..*
-----------
| Review   |
-----------

a Course either has associated review or not.  i.e a review can be written for the course or it may be skipped as well. 

** Multiplicity
0		no instances
0..1  	zero or exactly 1 instance 
1  		exactly one instance 
0..* 	zero or more instances 
*		zero or more instances 
1..* 	one or more instances 



** Navigability i.e. Association with 1 objets knowing about another and not vice-versa


 --------        --------
| Car    | <--  | Driver |
 --------        --------

A car is not aware of the driver. A driver knows about his/her car. a driver has a car 


** Aggregation 
is a specific case of association
has-a  relationship 

 -----------         --------
| Instuctor | <>--  | Course |
 -----------         --------

hollow diamon shape 

An instructor has a course to present

** Composition 
is a stronger case of aggregation
has-a  -> part-of

 -----          -------
| Car | <o>--  | Chassis|
 -----          -------

filled diamond shape

A car contains a Chassis  ( a car without tires is useless)
When a car is destroyed  a chassis is destroyed also  
versus  a course  can outlive his instructor.


** Realization
 -----------           ------------
| Interface | <|====  | Implementer|
 -----------           ------------

a hollow triangle with a dashed line 

implement a contract (behaviour)


** Dependeny 
Weak Relations

 -----         ------
| Car | <====  | Road |
 -----         ------

an arrow with a dashed line 

ex. object sends a notification to another object via fhird party
	a class receive a reference to another class via its member function argument


*** Sequence diagaram 

used for dynamic modelling 



 ------------           -----------
| Instance A |         | InstanceB |
 -----------            -----------
     |                       |
     |----------------------->
     |                       |
     |<......................|
     |                       |
     |                       |--
     |                       |  | 
     |                       |<-
     |                       |
     |                       X

----> message
<........ ansyc return message

message to self or a recursive call
--
  |
<-

a termination of an object's lifeline (destroying it)
X


####################
chap2 Singleton
####################

 * motivation
 * sessionState
 * thread-safety

only 1 instance exists. cannot be copied. 

use xcode projects vs playgrounds as multi-threading does not work well in playgrounds

create a xproject ios cocoa library  with unitTests
check results by testing with XCTest ! Cmd-U

library project: szi/m2-singleton/SessionState 

singleton impl
public class SessionState {
	private init(){}  //init() is private

	//a static  const property calls a private init
	public static let shared: SessionState = {
	  let instance = SessionState()
	  return intance
	}
}

2 projects versions

syncQueue  vs
asyncQueue  (performance)


########################
chap3 Prototype pattern
#######################

project (macos cmdline) szi/m3-prototype/Prototype

* avoid expensive initiazation

copy-on-write optimization 
	two copies point to the same location before one of copies is changed
	added specifically to swift

NSCopying protocol implementation for reference types. 

Shallow Copy vs Deep Copy  for reference types

Deep copy make sure that  NSCopying  copy() method ensures a proper copy() for every object's reference attribute
Deep copy can become a tedious task 

copy() must be correctly implemented over an entire object graph

so, rely on structs if possible which are value types, so do not need to worry about copying

** AddressBook demo
AddressBook is a class ( to have it shareable and mutable)
all others are structs to have deep copying for free
Contact
BasicInfo,
Title
Address
Employment 

summary: 
  prototype 
  	- use it when initializing new intances of a type is expensive
  	- crate clones by copying all the properties of the prototype instance (deep copy or value types)
  	- in swift value types are automatically clonded 
  	- adopt NSCopyping for classes 
  	- understand a difference between a shallow copy (copies pointers) vs Deep copy (copies attributes)
  	- check the entire object hierarchy when cloning



########################
chap4 Builder pattern
#######################

	encapsulate default configuation values 
	separates configuration values from the creation

	a demo: ThemeBuilder  
	project szi/m4-builder/Builder.playground


	summary: 
	 - use when initializing new instances of a type requires  many vlues
	 - and a majority of configuration defaults must not be changed


########################
chap5 factory pattern
#######################
   - hide initialization implementation concrete classes from callers
   - caller only knows abou the common protocol/base class and the factory method

   one of most widely used design patterns

project 3 playgrounds  ex/szi/m5-factory/
	ColorPalettes.playground # no pattern applied
	FactoryMethod.playground
	BaseClassFactory.playground 

    BasceClassFactoryBis   ios framework project with XCtests


########################
chap6 abstract factory pattern
#######################

- use it to create a group of related objects
- similar to the factory method pattern but produces a set of objects
- hides the factory classes  
	ability to modify the classes used to create objects without changing the callers 


   demo ComputerShopDemo  to create different configurations
   proj m6-abstractfactory/ComputerShop

 a base Object Factory has an associted enum of object types
 and a set of derived factories of objects corresponding to enum types 
 



