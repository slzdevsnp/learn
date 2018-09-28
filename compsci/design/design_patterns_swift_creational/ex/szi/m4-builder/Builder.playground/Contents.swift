//: Playground - noun: a place where people can play

import UIKit

public class Theme {
    public let backgroundColor: UIColor
    public let textColor: UIColor
    public let font: UIFont
    
    public init(backgroundColor: UIColor, textColor: UIColor, font: UIFont){
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.font = font
    }
    
    //
    // avoid many cascading inits
    //
    
    //add a convenience init, omit font param from a signature
    public convenience init(backgroundColor: UIColor, textColor: UIColor) {
        self.init(backgroundColor: backgroundColor, textColor: textColor,
                  font: UIFont.systemFont(ofSize: 15) )
    }
    
    public convenience init(backgroundColor: UIColor){
        self.init(backgroundColor: backgroundColor, textColor: UIColor.black)
    }
    public convenience init(){
        self.init(backgroundColor: UIColor.white )
    }
}


public class ThemeBuilder {
    public var backgroundColor = UIColor.white
    public var textColor = UIColor.black
    public var font = UIFont.systemFont(ofSize: 15)
    
    public init() {}
    
    public var theme: Theme {
        get {
            return Theme(backgroundColor: self.backgroundColor,
                         textColor: self.textColor, font: self.font)
        }
    }
}


//###########################
//#
//# main
//############################
let defaultTheme = Theme(backgroundColor: UIColor.white,
                         textColor: UIColor.black,font: UIFont.systemFont(ofSize: 15))

let label = UILabel(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 800, height: 44)))
label.backgroundColor = defaultTheme.backgroundColor
label.textColor = defaultTheme.textColor
label.font = defaultTheme.font
label.text = "White background, black text, system font 15"


let alertTheme = Theme(backgroundColor: UIColor.white,
                       textColor: UIColor.red, font: UIFont.systemFont(ofSize: 15))

let alertLabel = UILabel(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 800, height: 44)))
alertLabel.backgroundColor = alertTheme.backgroundColor
alertLabel.textColor = alertTheme.textColor
alertLabel.font = alertTheme.font
alertLabel.text = "White background, red text, system font 15"

/// lets redefine themes
let defaultThemeBis = Theme() //
let alertThemeBis = Theme(backgroundColor: UIColor.white, textColor: UIColor.red)

// create now a themeBuilder class which specifies defaults
let themeBuilder = ThemeBuilder()
let defaultThemeTri = themeBuilder.theme
label.backgroundColor = defaultThemeTri.backgroundColor
label.textColor = defaultThemeTri.textColor
label.font = defaultThemeTri.font
label.text = "Label with defaut theme from a builder" // chck the type at playground right

themeBuilder.backgroundColor = UIColor.yellow
let yellowTheme = themeBuilder.theme

label.backgroundColor = yellowTheme.backgroundColor
label.textColor = yellowTheme.textColor
label.font = yellowTheme.font
label.text = "label from yellow theme"





