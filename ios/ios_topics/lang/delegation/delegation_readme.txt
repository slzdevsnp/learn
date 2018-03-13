delegation design pattern
from
https://www.andrewcbancroft.com/2015/04/08/how-delegation-works-a-swift-developer-guide/#complete-example

delegation  is  about communiating between two classes
when 1 class gives a responsibility (delegates) for a certain task to another class


In ios and swift  a delegation desing pattern is done through abstraction layer : a protocol

a protocol defines a blueprint of methods, properties and other requirements (think of header fil  in c , cpp)

When a class adheres to a protocol it provides a guarantee that it provides the named behavior  specified in the protocol

a protocol is a contract


3 players
A protocol defining the responsibilities that will be delegated
A delegator, which depends on an instance of something conforming to that protocol
A delegate, which adopts the protocol and implements its requirements

A delegator class typically defines a variable property with the word “delegate” somewhere in the name 

