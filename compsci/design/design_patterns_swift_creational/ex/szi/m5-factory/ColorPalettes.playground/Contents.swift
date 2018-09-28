//: ColorPalettes

import UIKit

public protocol ColorPalette {
    var backgroundColor: UIColor {get}
    var textColor: UIColor {get}
}

//create structs for specific color palettes
struct WhiteboardPalette: ColorPalette {
    public var backgroundColor: UIColor {
        get {
            return UIColor.white
        }
    }
    public var textColor: UIColor {
        get {
            return UIColor.black
        }
    }
}

struct BlackboardPalette: ColorPalette {
    public var backgroundColor: UIColor {
        get {
            return UIColor.black
        }
    }
    public var textColor: UIColor {
        get {
            return UIColor.white
        }
    }
}
struct MilkCoffeePalette: ColorPalette {
    public var backgroundColor: UIColor {
        get { return UIColor.brown }
    }
    public var textColor: UIColor {
        get { return UIColor.white }
    }
}


// fourth palette
struct NightSwimmingPalette: ColorPalette {
    
    public var backgroundColor: UIColor {
        get {
            return UIColor(hex: 0x191970) // HTML #191970  (made available in extension)
        }
    }
    public var textColor: UIColor {
        get {
            return UIColor.white
        }
    }
}
extension UIColor {
    /// Converts 6-digit hexadecimal color codes
    ///
    /// - Parameter hex: HTML color code
    convenience init(hex: UInt32) {
        
        let divisor = Float(255)
        let red     = Float((hex & 0xFF0000) >> 16) / divisor
        let green   = Float((hex & 0x00FF00) >>  8) / divisor
        let blue    = Float( hex & 0x0000FF       ) / divisor
        
        self.init(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1)
    }
}

//###########################
//#
//#  main
///##########################

let label = UILabel(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 600, height: 44)))
label.textAlignment = .center

let whiteboardPalette = WhiteboardPalette()
label.backgroundColor = whiteboardPalette.backgroundColor
label.textColor = whiteboardPalette.textColor
label.text = "Whiteboard Palette"

let blackboardPalette = BlackboardPalette()
label.backgroundColor = blackboardPalette.backgroundColor
label.textColor = blackboardPalette.textColor
label.text = "Blackboard Palette"

let milkCoffeePalette = MilkCoffeePalette()
label.backgroundColor = milkCoffeePalette.backgroundColor
label.textColor = milkCoffeePalette.textColor
label.text = "MilkCoffee Palette"

let nightSwimmingPalette = NightSwimmingPalette()
label.backgroundColor = nightSwimmingPalette.backgroundColor
label.textColor = nightSwimmingPalette.textColor
label.text = "NightSwimming Palette"

//the big problem is that callers must know every implementation class

