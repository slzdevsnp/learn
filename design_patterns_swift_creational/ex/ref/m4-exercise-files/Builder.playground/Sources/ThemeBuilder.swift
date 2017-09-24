import UIKit

public class ThemeBuilder {
    public var backgroundColor = UIColor.white
    public var textColor = UIColor.black
    public var font = UIFont.systemFont(ofSize: 15)
    
    public init () {}
    
    public var theme: Theme {
        get {
            return Theme(backgroundColor: self.backgroundColor, textColor: self.textColor, font: self.font)
        }
    }
}
