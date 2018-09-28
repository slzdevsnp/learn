// Playground - noun: a place where people can play

import UIKit

// ----- variable declaration -----
var name: String?
var job: String!
var city: String

// Commenting-out these lines will leave "name" and "job" set to nil which
// will affect the subsequent statements
name = "Alex"
job = "iOS Developer"
city = "Seattle"

// ----- If statement with forced unwrapping -----
if name != nil {
    println("name is \(name)")
}
else {
    println("name is nil")
}

if job != nil {
    println("job is \(job)")
}
else {
    println("job is nil")
}

println("city is \(city)")

// You can't check to see if a non-optional type is nil. By definition it CAN'T EVER be nil
//if city != nil {
//    println("City is \(city)")
//}
//else {
//    println("city is nil")
//}

// ----- Optional binding -----
if let theName = name {
    println("name is \(theName)")
}
else {
    println("name is nil")
}

if let theJob = job {
    // Because "job" is declared as an Implicitly Unwrapped Optional we can
    // access the value directly without the ! syntax
    println("job is \(job)")
}
else {
    println("job is nil")
}

// ---- The nil-coalescing operator -----

let finalName = (name ?? "no name")
let finalJob = (job ?? "no job")
println("Name: \(finalName), Job: \(finalJob)")

// ----- Direct access -----
println("name is \(name!)")
println("job is \(job!)")

// if "name" is nil, this statement will fail at runtime
//println("and name! is \(name!)")
//println("and job! is \(job!)")
