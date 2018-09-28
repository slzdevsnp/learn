design patterns in swift : structural 

Karoly Nyisztor
DEVELOPER
@knyisztor www.leakka.com

###########
# ch1 Overview
############

Structural Design Patterns
{Adapter, Bridge, Decorator, Composite, Façade, Flyweight, Proxy}


###########
# ch2 Adapter
############

demo: SocialSharing
project  ex/szi/m2-adapter/SocialSharingWithAdaptor

 - thhird-party / legacy code
 		we cannot modify the interface 

 - adapt the incompatible interface

 summary:
 	- converts an incompatible inerface into one we need
 	- should be used when we cannot modify the source code
    - adapter can save us from a lot of refactoring work
    

###########
# ch3 Bridge
############
project  ex/szi/m3-bridge/MessengerBridge

- motivation 
	- solve exploding class hierarchy problem (high number of iplementation classes)
    - by decoupling shared and specific functionality 

    pitfalls:
    - commmon and specific functionality not separated
- check diagrams

###########
# ch4 Composite
############

  demo listFiles 
  proj  ex/szi/m4-composite/ListFilesComposite

 - simplify objects by making them conform to a common contract 
 - treat various elements in collection in the same manner

  pitfalls: allow changes of the composite structure


###########
# ch5 decorator
############
    demo 
    proj: ls ex/szi/m5-decorator/SwiftExtensions   check for BorderedLabelDecorator
    
 - allow new behavior to existing type
 - can be implemented via:
 	object wrapping
 	swift extensions


swift extensions can do:
	add computed properties, dein

###########
# ch6 facade
############
 - simple and very useful pattern
  - simplifies  the use of complex api
  - wraps types belonging to a complex subsystem
  - proved a one straightforward interface
  - subsystem classes can still be accessed for lower leel functionality
   
  * pitfaulls
    exposes details of the underlying objects

  demo  Downloader urls framework
  ex/szi/m6-facade/UDownloader
    Downloader contains  a complex static method donwload 

    this method is tested  in  testDownloadToFile()  XCTest file


###########
# ch7 flyweight
############

demo flyweightLogger 

motivation 
	- share one instance to represent many  (sharing of common objects)
		saves memory by reducing number of object instances at runtime
	- separate state-dependent part
	- store intrinsinc/immutable state in  flyweight object
	- extrinsic state managed by clients 
    
    Pitfalls
    	- allow changes of the immutable state
    	- not protecting agains concurrent access
    	=> thread safety is imperative

    for e.g.  text editor : { 200 pages, 1500 characters/page, 300'000 character objects}
    character object
    	character  <- caller can not change the char value  (intrinsic state attribute)
    	size       <-  caller can change size or color  (extrinsic state attributes)
    	color


    -> create 26 objects to map  letters of english alphabet	

demo we are going to implement a loggin framework to create dedicated loggers 
 proj:  ex/szi/m7-flyweight/UflyweighLoger 


###########
# ch8 proxy
############

motivation:
	- control object access
	- define a proxy object 
	- clients use the proxy , not the underlying object
	- the proxy forwards and adapts client requests

proxy types
	- remote proxy 
	- virtual proxy (for expensive ressources)
	- protective proxy (control access to sensitive objects)

	pitfalls
	- allow instantiation of proxied types

demos: 
	remoteDataProxy (remote proxy in action)   Remote_RemoteDataProxy playground

	imageProxy (virtual proxy)

	secureImageProxy (protextive proxy)

	ex/szi/m8-proxy

