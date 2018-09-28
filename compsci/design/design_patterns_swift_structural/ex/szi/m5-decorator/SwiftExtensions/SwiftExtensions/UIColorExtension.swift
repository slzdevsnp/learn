//
//  UIColorExtension.swift
//  SwiftExtensions
//
//  Created by Sviatoslav Zimine on 9/25/17.
//  Copyright © 2017 sviatoslav.zimin. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(hex: UInt32) {
        let divisor = Float(255)
        let red     = Float((hex & 0xFF0000) >> 16) / divisor
        let green   = Float((hex & 0x00FF00) >> 8) / divisor
        let blue    = Float(hex & 0x0000FF) / divisor
        self.init(colorLiteralRed: red, green: green, blue: blue, alpha: 1)
    }
}


//create a label with rounded borders

class BorderedLabelDecorator: UILabel {
    fileprivate let wrappedLabel: UILabel
    
    required init(label: UILabel, cornerRadius: CGFloat = 3.0, borderWidth: CGFloat = 1.0, borderColor: UIColor = .black) {
        self.wrappedLabel = label
        super.init(frame: label.frame)
        
        wrappedLabel.layer.cornerRadius = cornerRadius   //modification of default behavior
        wrappedLabel.layer.borderColor = borderColor.cgColor
        wrappedLabel.layer.borderWidth = borderWidth
        wrappedLabel.clipsToBounds = true
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var textAlignment: NSTextAlignment {
        get {
            return wrappedLabel.textAlignment
        }
        set {
            wrappedLabel.textAlignment = newValue
        }
    }
    
    override var backgroundColor: UIColor? {
        get {
            return wrappedLabel.backgroundColor
        }
        set {
            wrappedLabel.backgroundColor = newValue
        }
    }
    
    override var textColor: UIColor? {
        get {
            return wrappedLabel.textColor
        }
        set {
            wrappedLabel.textColor = newValue
        }
    }
    
    override var text: String? {
        get {
            return wrappedLabel.text
        }
        set {
            var str = "😸"  //decoration of wrapped object
            if let newVal = newValue {
                str += newVal + str
            }
            wrappedLabel.text = str
        }
    }
    override var layer: CALayer {
        return wrappedLabel.layer
    }
}
