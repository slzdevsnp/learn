//: Playground - noun: a place where people can play

//neuburg 1  pp 50

import UIKit

//MARK: - anonymous functions

func doSteps(x: String, step:(_ ok:Bool) -> () ) {
    print("firstly printing \(x)")
    
    step(false) // in func definition a param is specified
}               // which is used when the func is called and anonym func defined !

print("== anonymous functions")
doSteps(x:"hello world",
        step: {
            (ok:Bool) -> () in  //anonymous function's signature followed by in
            let x = 12
            print("next step: greetings \(x) times \(ok)")
        })

doSteps(x:"goodbye world",
        step: {
            (ok:Bool) -> () in  //anonymous function's signature followed by in
            let x = 1
            if !ok {
                print("next step: greetings \(x) times \(ok)")
            }
})


//MARK: - apply to arrays
let arr = [2,4,6,8,10]
print("== apply annonymous function to array")
print("initial array \(arr)")

let arr2 = arr.map({
    (i:Int) -> Int  in
    return i*2
})
print("after transform:\(arr2)")

let arr3 = arr.map({$0*$0})
print("swiftier version \(arr3)")

print("arr in cubic \(arr.map({$0*$0*$0}))")

//MARK: - define and call 

/*
 {
    // ... code goes here
 }()
 
 */



