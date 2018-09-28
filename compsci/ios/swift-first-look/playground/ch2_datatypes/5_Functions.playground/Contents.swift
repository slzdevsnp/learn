//: Playground - noun: a place where people can play

import UIKit

func say(phrase: String) -> Void {
    print ("saying loud.. \(phrase)")
}

say(phrase: "hello world")

func say(phrase: String, times: Int) {
    for i in 0...times{
        say(phrase: phrase) // delegating a call to the previously defined func say
        print("for \(i)th time")
    }
}

say(phrase: "hello my world", times:2)

func sayb(phrase str: String, times n: Int) { // 2 arguments with external and internal n
    for _ in 0...n{ // _ is a counter variable which is never used
        say(phrase: str) //str is an internal name
    }
}

sayb(phrase: "hello  from alt world", times:2)





