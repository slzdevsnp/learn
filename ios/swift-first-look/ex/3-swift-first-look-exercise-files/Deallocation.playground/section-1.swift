// Playground - noun: a place where people can play

import UIKit

class Foo {
    deinit {
        println("This foo is outta here")
    }
}

var stuff = [Foo()]
stuff.removeLast()
