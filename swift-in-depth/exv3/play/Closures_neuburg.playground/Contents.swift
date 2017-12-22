//: Playground - noun: a place where people can play

import UIKit

//Closures  page 53 Nubrug book1

class Dog {
    var whatThisDogSays = "woof"
    
    // bark is function is a closure, it has access to refrences
    // of variables defined outside its scope  i.e. soundthisDogSays
    func bark() {
        print("a dog says: \(self.whatThisDogSays)")
    }
    
    static func id(){
        print("this is dog")
    }
}

let dog1 = Dog()
dog1.bark()

func doThis(_ f: () -> () ) {
    f()
}
let d = Dog()
d.whatThisDogSays = "gav gav"
let barkFunction = d.bark

doThis(barkFunction)
doThis(Dog.id) // passing to doThis a static function

//more amazing
d.whatThisDogSays = "moot" //i.e. doThis maintaince a reference to d.bark() instance func
doThis(barkFunction)


// how closures improve your code
// closes can help make your code more general and hence more useful

// this func has a function whattoDraw param  which can be antyhing with appropriate type
func imageOfSize(_ size:CGSize, _ whatToDraw:() -> ()) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(size, false, 0)
    whatToDraw()
    let result = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return result
}

//using thsi function, we specify what to drawo in the closure:  it is  a UBezierPath
//UBezierPath.stroke() is specified for whatToDraw
// we also access in closure variables defined exteranlly to its scope
let sz=CGSize(width:45, height:20)
let radiusvalue = CGFloat(8)
let image =  imageOfSize(sz) {
    let p = UIBezierPath(roundedRect: CGRect(origin:CGPoint.zero, size:sz),
                       cornerRadius:radiusvalue)
    p.stroke()
}

//lets create a func for rounded rectangles
func makeRoundedRectangle(_ sz:CGSize, radius: CGFloat) -> UIImage {
    let image = imageOfSize(sz) {
        let p = UIBezierPath(
            roundedRect: CGRect(origin:CGPoint.zero, size:sz),
            cornerRadius: radius)
        p.stroke() }
    return image
}


//function returning a function





