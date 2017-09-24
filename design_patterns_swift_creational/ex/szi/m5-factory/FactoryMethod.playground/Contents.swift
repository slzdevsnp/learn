//: Palettes with FactoryMethod

import UIKit

public enum ColorTheme {
    case whiteboard
    case blackboard
    case milkCoffee
    case nightSwimming
    case pinky
}

// a global function to return a specific palette
func makePalette(theme: ColorTheme) -> ColorPalette {
    switch (theme){
    case .blackboard: return BlackboardPalette()
    case .whiteboard: return WhiteboardPalette()
    case .milkCoffee: return MilkCoffeePalette()
    case .nightSwimming: return NightSwimmingPalette()
    case .pinky: return PinkyPalette()
    }
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
        
        self.init(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1)
    }
}

//structs for individual palettes as before
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



//################################
//#
//# main
//#
//################################
let label = UILabel(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 600, height: 44)))
label.textAlignment = .center

let whiteboardPalette = makePalette(theme: .whiteboard)  // we do not need to know the specific class
label.backgroundColor = whiteboardPalette.backgroundColor
label.textColor = whiteboardPalette.textColor
label.text = "Whiteboard Palette"


let pinkPalette = PaletteFactory.makePalette(theme: .pinky)
label.backgroundColor = pinkPalette.backgroundColor
label.textColor = pinkPalette.textColor
label.text = "Whiteboard Palette"



