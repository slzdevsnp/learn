//: Playground - noun: a place where people can play

import Foundation

///MARK: -Memory management    

//no garbage collector due to objective-C legacy, do need to prevent memory leakage
// swift adopts the objective-C memory management system
//the problem.. !!! circular references.  always thing about potential memory leakage problem

private class Node<T>{
    var val: T
    var next: Node? = nil
    var previous: Node? = nil
    init(_ val: T){ self.val = val}
}

//double linked list
public class List<T>{
    private var head: Node<T>?
    
    public func clear() { head = nil }
    
    public func insert(val:T){
        let new = Node(val)
        new.next = nil
        new.previous = nil
        if let first = head{
            first.previous = new
            new.next = first
        }
        head = new
    }
    public func printValues(){
        var el = head
        while ( true )
        {
            print(el!.val)
            if el!.next == nil { break}
            el = el!.next
        }
        
    }
}

var l = List<String>()
l.insert("a")
l.insert("b")
l.insert("c")
l.insert("d")



l.printValues()

l.clear()
// after this nodes for d c, b, a  are not deleted

///MARK: - weak reference

//objects should have independent life cycle  i.e. can leave independently along each other
class Committee {
    
    var members: [Person] = []
    func join (newMember:Person){
        members.append(newMember)
    }
}
class Person{
    weak var myCommittee: Committee? // observe weak , can only be a pointer variable
    func join ( committee: Committee){
        myCommittee = committee
        committee.join( self )
    }
}

var cm = Committee()
var prs = Person() 
prs.join(cm)

///MARK : - unowned reference

//objects should have the same life cycle  i.e. live or die only together 

class Order{
    unowned var placedBy: Customer  // observe unowned, observe that this is not a pointer variable
    init(placedBy: Customer){
        self.placedBy = placedBy
    }
}
class Customer {
    var myOrders: [Order] = []
    //..
}

var cms = Customer()
var ord = Order(placedBy: cms)

///MARK: - captured list  for functions
class  HTMLElement {
    let tag: String
    let content: String?
    init(_ tag: String, content: String){
        self.tag = tag
        self.content = content
    }
    
    lazy var asHTML: ()-> String = {  //observe lazy
        [unowned self] in             //observe [unowned self]  in closure defintion
        return self.content == nil
            ? "<\(self.tag) />"
            : "<\(self.tag)>\(self.content!)</\(self.tag)>"
    }
}

let title = HTMLElement("title", content: "Hello")
print ( title.asHTML() )

let header = HTMLElement("head", content: "" )
print ( header.asHTML() )




