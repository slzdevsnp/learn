//: The Factory Method encapsulated in the base class it operates on
import UIKit

/// ColorPalette base class
public class ColorPalette {
    
    fileprivate var backgroundColorInternal: UIColor
    fileprivate var textColorInternal: UIColor
    
    final public var backgroundColor: UIColor {
        get {
            return backgroundColorInternal
        }
    }
    
    final public var textColor: UIColor {
        get {
            return textColorInternal
        }
    }
    
    fileprivate init(backgroundColor: UIColor, textColor: UIColor) {
        self.backgroundColorInternal = backgroundColor
        self.textColorInternal = textColor
    }
    
    /// Creates ColorPalette subclass instances based on the theme argument value
    public class func make(theme: ColorTheme) -> ColorPalette {
        var result: ColorPalette
        
        switch(theme) {
        case .blackboard: result = BlackboardPalette()
        case .whiteboard: result = WhiteboardPalette()
        case .milkCoffee: result = MilkCoffeePalette()
        case .nightSwimming: result = NightSwimmingPalette()
        case .pinky: result = PinkyPalette()
        }
        
        return result
    }
}

public enum ColorTheme {
    case whiteboard
    case blackboard
    case milkCoffee
    case nightSwimming
    case pinky
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

class WhiteboardPalette: ColorPalette {
    
    fileprivate init() {
        super.init(backgroundColor: UIColor.white, textColor: UIColor.black)
    }
}

class BlackboardPalette: ColorPalette {
    
    fileprivate init() {
        super.init(backgroundColor: UIColor.black, textColor: UIColor.white)
    }
}

class MilkCoffeePalette: ColorPalette {
    
    fileprivate init() {
        super.init(backgroundColor: UIColor.brown, textColor: UIColor.white)
    }
}

class NightSwimmingPalette: ColorPalette {

    fileprivate init() {
        super.init(backgroundColor: UIColor(hex: 0x191970), textColor: UIColor.white)
    }
}

class PinkyPalette: ColorPalette {
    
    fileprivate init() {
        super.init(backgroundColor: UIColor(hex: 0xF573A1), textColor: UIColor.white)
    }
}

/*:
 ### The Factory Method in action
 */
let label = UILabel(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 600, height: 44)))
label.textAlignment = NSTextAlignment.center

let whiteboardPalette = ColorPalette.make(theme: .whiteboard)
label.backgroundColor = whiteboardPalette.backgroundColor
label.textColor = whiteboardPalette.textColor
label.text = "Whiteboard Palette"

let blackboardPalette = ColorPalette.make(theme: .blackboard)
label.backgroundColor = blackboardPalette.backgroundColor
label.textColor = blackboardPalette.textColor
label.text = "Blackboard Palette"

let milkCoffeePalette = ColorPalette.make(theme: .milkCoffee)
label.backgroundColor = milkCoffeePalette.backgroundColor
label.textColor = milkCoffeePalette.textColor
label.text = "MilkCoffee Palette"

let nightSwimmingPalette = ColorPalette.make(theme: .nightSwimming)
label.backgroundColor = nightSwimmingPalette.backgroundColor
label.textColor = nightSwimmingPalette.textColor
label.text = "NightSwimming Palette"

let pinkyPalette = ColorPalette.make(theme: .pinky)
label.backgroundColor = pinkyPalette.backgroundColor
label.textColor = pinkyPalette.textColor
label.text = "Pinky Palette"
