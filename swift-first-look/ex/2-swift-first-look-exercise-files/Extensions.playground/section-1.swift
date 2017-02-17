// Playground - noun: a place where people can play

import UIKit

extension String {
    func reverse() -> String {
        let chars = Array(self).reverse()
        var reversed = ""
        for char in chars {
            reversed.append(char)
        }
        
        return reversed
    }
}

let name = "Alex Vollmer"
name.reverse()

