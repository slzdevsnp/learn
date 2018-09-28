// Playground - noun: a place where people can play

import UIKit

func say(phrase: String) {
    println(phrase)
}

say("Hello there!")

// NOTE: the commented lines here show some permutations
// of argument syntax in "raw" functions. Unless you
// explicitly require the argument name (either with
// the '#' or by providing an internal AND external
// argument name, you call the function with 
// positional arguments only.

//func say(phrase: String, times: Int) {
func say(phrase: String, #times: Int) {
//func say(phrase: String, times n: Int) {
    for i in 0...times {
        say(phrase)
    }
}

//say("Hello there!", 10)
//say("Hello there!", 10)
say("Hello there!", times: 10)
