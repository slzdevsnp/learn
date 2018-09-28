//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground from hell"

let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
label.backgroundColor = UIColor.lightGray

var x = 0

for i in 1...100 {
    x = i*i
    label.text = "x now is \(x)"
    label.sizeToFit()
}
