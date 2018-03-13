//
//  Employee.swift
//  CustomizationDemo
//
//  Copyright © 2017 roga_kopyta. All rights reserved.
//

import Foundation
//-------------------------------------------------

public class Employee {
    private let name : String  //local fields are not public
    internal  let payGrade : Int
    
    init ( name: String, payGrade : Int){
        self.name = name
        self.payGrade = payGrade
    }
    
}
//---------------------------------------------------
extension Employee: Equatable {}  //this ensuares  == oper can be 
                                  //applied to Employee class

/*operator overload  is in a global function defined outside of 
 Equatable protocol */
public func == (lhs:Employee, rhs:Employee) -> Bool {
    return lhs.name == rhs.name && lhs.payGrade == rhs.payGrade
}
//-----------------------------------
extension Employee: Hashable { //requires Equatable
    public var hashValue: Int { return name.hashValue }
}

//---------------------------------------------------
extension Employee: Comparable {}//need to immpl as global >,<,>=,<=

public func < (lhs:Employee, rhs:Employee) -> Bool {
    return lhs.name < rhs.name && lhs.payGrade < rhs.payGrade
}
public func <= (lhs:Employee, rhs:Employee) -> Bool {
    return lhs.name <= rhs.name && lhs.payGrade <= rhs.payGrade
}
public func > (lhs:Employee, rhs:Employee) -> Bool {
    return lhs.name > rhs.name && lhs.payGrade > rhs.payGrade
}
public func >= (lhs:Employee, rhs:Employee) -> Bool {
    return lhs.name >= rhs.name && lhs.payGrade >= rhs.payGrade
}

//---------------------------------------------------
extension Employee: CustomStringConvertible,
CustomDebugStringConvertible {
    
    public var description: String {
        return name
    }
    public var debugDescription: String {
        return "\(name):\(payGrade)"
    }
    
}

