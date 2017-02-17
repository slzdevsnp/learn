// Playground - noun: a place where people can play

import UIKit

let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
label.backgroundColor = UIColor.lightGrayColor()
var x = 0
for i in 1...100 {
    x = i * i
    label.text = "x is now \(x)"
    label.sizeToFit()
}

