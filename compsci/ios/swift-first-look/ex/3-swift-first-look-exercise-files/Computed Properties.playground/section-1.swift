// Playground - noun: a place where people can play

import UIKit

class Distance {
    let FEET_PER_METERS = 3.28084

    // Make meters our internal unit-of-measurement
    var meters: Double = 0
    
    // Calculate feet/meters conversion
    var feet: Double {
        get {
            return self.meters * FEET_PER_METERS
        }
        
        set {
            self.meters = newValue / FEET_PER_METERS
        }
    }
    
    init(meters: Double) {
        self.meters = meters
    }
}

let dist = Distance(meters: 10)
dist.meters

// Computed "getter" returns translation from meters to feet
dist.feet

// Setting "feet" properties triggers feet-to-meters conversion
dist.feet = 12

// internal storage is updated
dist.meters
