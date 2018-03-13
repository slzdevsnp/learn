//: Playground - noun: a place where people can play

import UIKit

var name: String?
var job: String!
var city: String

name = "Alex"
job = "IOS Dev"
city = "Seattle"

if name != nil {
    print("name is \(name)")
    print("strong name is \(name!)")  //name! is unwrapping a value of an optional variable
}else{
    print("name is nil")
}

if job != nil {
    print("job is \(job)")
}else{
    print("job is nil")
}

if city != nil{
    print("city is \(city)")
}else{
    print("city is nil")
}

print("accessing city \(city)")

job = nil
// coalesc operator ??
let finalName = ( name ?? "no name")
let finalJob = (job ?? "no job")
let finalcity = (city ?? "no city")

