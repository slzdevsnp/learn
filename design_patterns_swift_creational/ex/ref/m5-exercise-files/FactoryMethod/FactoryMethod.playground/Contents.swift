//: Factory Method
//:> The factory method pattern exposes only a protocol or a base class and hides all the details of the implementation classes. The logic required to select the appropriate implementation class is encapsulated in a single method. This method stands at the core of the Factory Method pattern; it defines the parameters required to select the implementation class, and returns an implementation of the protocol.
import UIKit

/// Creates a color palette based on the passed color theme value
///
/// - Parameter theme: color theme
/// - Returns: instance of a class which adopts the ColorPalette protpcol
func makePalette(theme: ColorTheme) -> ColorPalette {
    switch(theme) {
    case .blackboard: return BlackboardPalette()
    case .whiteboard: return WhiteboardPalette()
    case .milkCoffee: return MilkCoffeePalette()
    case .nightSwimming: return NightSwimmingPalette()
    case .pinky: return PinkyPalette()
    }
}

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

struct PinkyPalette: ColorPalette {
    
    public var backgroundColor: UIColor {
        get {
            return UIColor(hex: 0xF573A1) // HTML #F573A1
        }
    }
    
    public var textColor: UIColor {
        get {
            return UIColor.white
        }
    }
}


/*:
 ### The factory method exposed as a class method
 */
public class PaletteFactory {
    public class func makePalette(theme: ColorTheme) -> ColorPalette {
        switch(theme) {
        case .blackboard: return BlackboardPalette()
        case .whiteboard: return WhiteboardPalette()
        case .milkCoffee: return MilkCoffeePalette()
        case .nightSwimming: return NightSwimmingPalette()
        case .pinky: return PinkyPalette()
        }
    }
}

/*:
 ### The Factory Method in action
 */
let label = UILabel(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 600, height: 44)))
label.textAlignment = NSTextAlignment.center

let whiteboardPalette = PaletteFactory.makePalette(theme: .whiteboard)//makePalette(theme: .whiteboard)
label.backgroundColor = whiteboardPalette.backgroundColor
label.textColor = whiteboardPalette.textColor
label.text = "Whiteboard Palette"

let blackboardPalette = makePalette(theme: .blackboard)
label.backgroundColor = blackboardPalette.backgroundColor
label.textColor = blackboardPalette.textColor
label.text = "Blackboard Palette"

let milkCoffeePalette = makePalette(theme: .milkCoffee)
label.backgroundColor = milkCoffeePalette.backgroundColor
label.textColor = milkCoffeePalette.textColor
label.text = "MilkCoffee Palette"

let nightSwimmingPalette = makePalette(theme: .nightSwimming)
label.backgroundColor = nightSwimmingPalette.backgroundColor
label.textColor = nightSwimmingPalette.textColor
label.text = "NightSwimming Palette"

//:> Now, even if we add a new ColorPalette class, the caller won't be affected, except it must know the new enum value it should supply to the factory method
let pinkyPalette = makePalette(theme: .pinky)
label.backgroundColor = pinkyPalette.backgroundColor
label.textColor = pinkyPalette.textColor
label.text = "Pinky Palette"
