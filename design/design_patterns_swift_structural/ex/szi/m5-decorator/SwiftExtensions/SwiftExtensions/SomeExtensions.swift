//
//  SomeExtensions.swift
//  SwiftExtensions
//
//  Created by Sviatoslav Zimine on 9/25/17.
//  Copyright © 2017 sviatoslav.zimin. All rights reserved.
//

import UIKit

// allow to Double to have a fahrenheit property
extension Double {
    public var celsius: Double { return self }
    public var fahrenheit: Double { return (self * 1.8) + 32 }
}

//define new method in extension
extension String {
    public func isLowercase() -> Bool {
        return self == self.lowercased()
    }
}

//provide new initializers

extension CGVector {
    public init(point: CGPoint) {
        self.init(dx: point.x, dy: point.y)
    }
}

//define subscripts
extension String {
    public subscript(index: Int ) -> Character {
        guard index >= 0 else {
            return "☠"
        }
        guard let idx = self.index(self.startIndex, offsetBy: index, limitedBy: self.endIndex) else {
            return "☠"
        }
        return self[idx]
    }
}

// define and use new nested types
public enum CaseType {
    case lowerCase, upperCase, mixedCase
}

extension String {
    public var caseType: CaseType {
        switch self {
        case let str where str == str.uppercased():
            return CaseType.upperCase
        case let str where str == str.lowercased():
            return CaseType.lowerCase
        default:
            return CaseType.mixedCase
        }
    }
}
