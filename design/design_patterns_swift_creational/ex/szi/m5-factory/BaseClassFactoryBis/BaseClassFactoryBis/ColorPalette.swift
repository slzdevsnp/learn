//
//  ColorPalette.swift
//  BaseClassFactoryBis
//
//  Created by Sviatoslav Zimine on 9/24/17.
//  Copyright © 2017 sviatoslav.zimin. All rights reserved.
//

import UIKit

public enum ColorTheme {
    case whiteboard
    case blackboard
    case milkCoffee
    case nightSwimming
    case pinky
}



/// ColorPalette base class with a factory method
public class ColorPalette {
    
    fileprivate var backgroundColorInternal: UIColor
    fileprivate var textColorInternal: UIColor
    
    //final used so that derived classes cannot overrrid this property
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

//concreete classes non structures because subclassing not permitted on structures
class WhiteboardPalette: ColorPalette {
    fileprivate init() { //fileprivate init prevents callers to initialized a ColorPalette subclass
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

