//: Factory Method
//: > This demo illustrates the problem that is solved by the Factory method pattern
import UIKit

public enum ColorTheme {
    case whiteboard
    case blackboard
    case milkCoffee
    case nightSwimming
    case pinky
}

/// Protocol for color palettes
public protocol ColorPalette {
    var backgroundColor: UIColor {get}
    var textColor: UIColor {get}
}

// Let's create two color palettes: whiteboard and blackboard
// We'll use them to change the attributes of a UILabel
// If I add a new MilkCoffee color palette, the caller must know about this one, too.
// And if I add a fourth one, that will also appear on the caller side.

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
        get {
            return UIColor.brown
        }
    }
    
    public var textColor: UIColor {
        get {
            return UIColor.white
        }
    }
}

// fourth palette
struct NightSwimmingPalette: ColorPalette {
    
    public var backgroundColor: UIColor {
        get {
            return UIColor(hex: 0x191970) // HTML #191970
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
        
        self.init(colorLiteralRed: red, green: green, blue: blue, alpha: 1)
    }
}

/*:
 ### Create ColorPalette instances
 */
let label = UILabel(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 600, height: 44)))
label.textAlignment = NSTextAlignment.center

let whiteboardPalette = WhiteboardPalette()
label.backgroundColor = whiteboardPalette.backgroundColor
label.textColor = whiteboardPalette.textColor
label.text = "Whiteboard Palette"

let blackboardPalette = BlackboardPalette()
label.backgroundColor = blackboardPalette.backgroundColor
label.textColor = blackboardPalette.textColor
label.text = "Blackboard Palette"

/*:
>The issue is that callers must know every implementation class.
>Whenever we add a new ColorPalette class, the caller must include that, too.
>Such dependencies between classes should be avoided, since changes will have ripple effects throughout the application.
*/
let milkCoffeePalette = MilkCoffeePalette()
label.backgroundColor = milkCoffeePalette.backgroundColor
label.textColor = milkCoffeePalette.textColor
label.text = "MilkCoffee Palette"

let nightSwimmingPalette = NightSwimmingPalette()
label.backgroundColor = nightSwimmingPalette.backgroundColor
label.textColor = nightSwimmingPalette.textColor
label.text = "NightSwimming Palette"
