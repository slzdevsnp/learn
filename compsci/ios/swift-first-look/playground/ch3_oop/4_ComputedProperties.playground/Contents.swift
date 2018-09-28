//: Playground - noun: a place where people can play

import UIKit


class Distance {
    let FEET_PER_METERS = 3.28084
    
    var meters: Double = 0
    
    init(meters: Double){
        self.meters = meters
    }
    
    //computed property this is to replace funs such as getInFeeet()
    var feet: Double {
        // getter and setter can be defined
        get{
            return self.meters * FEET_PER_METERS
        }
        set{
            self.meters = newValue / FEET_PER_METERS
        }
    }
    
    func getInFeet() -> Double {
        return self.meters * FEET_PER_METERS
    }
    
}



let d = Distance(meters: 10)
print("in feets \(d.feet)")
//print("in feets bis \(d.getInFeet() )")

d.feet = 33
print("in feets  after seting \(d.feet)")
print ("in meters after setting \(d.meters)")
