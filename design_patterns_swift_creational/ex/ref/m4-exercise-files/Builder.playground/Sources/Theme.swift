import UIKit

public class Theme {
    
    public let backgroundColor: UIColor
    public let textColor: UIColor
    public let font: UIFont
    
    // Use default values instead of telescoping initializers
    // The telescoping constructor anti-pattern occurs when the increase of object constructor parameter combination leads to an exponential list of constructors. Instead of using numerous constructors, the builder pattern uses another object, a builder, that receives each initialization parameter step by step and then returns the resulting constructed object at once.
    public init(backgroundColor: UIColor = UIColor.white, textColor: UIColor = UIColor.black, font: UIFont = UIFont.systemFont(ofSize: 15)) {
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.font = font
    }
    
    /*
     // Telescoping initializers (anti-pattern)
     public init(backgroundColor: UIColor, textColor: UIColor, font: UIFont, fontSize: CGFloat) {
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.font = font.withSize(fontSize)
     }

    public convenience init(backgroundColor: UIColor, textColor: UIColor, font: UIFont) {
        self.init(backgroundColor:backgroundColor, textColor:textColor, font: UIFont.systemFont(ofSize: 15), fontSize: 15)
    }
    
    // "telescoping" initializers
    public convenience init(backgroundColor: UIColor, textColor: UIColor) {
        self.init(backgroundColor:backgroundColor, textColor:textColor, font: UIFont.systemFont(ofSize: 15))
    }
    
    public convenience init(backgroundColor: UIColor) {
        
        self.init(backgroundColor: backgroundColor, textColor: UIColor.black)
    }
    
    public convenience init() {
        self.init(backgroundColor: UIColor.white)
    }
     */
}
