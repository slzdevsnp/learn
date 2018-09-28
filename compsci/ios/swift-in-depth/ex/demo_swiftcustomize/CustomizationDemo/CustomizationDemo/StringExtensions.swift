
//  StringExtensions.swift
//  Copyright © 2017 roga_kopyta. All rights reserved.
//

import Foundation

//--------------------------------------------------
public extension String{
    public var count:Int { return characters.count }
}

//--------------------------------------------------
extension String : IntegerLiteralConvertible {
    public init(integerLiteral value: Int){
        self = "\(value)"
    }
}
//--------------------------------------------------
public extension String {
    public subscript (index : Int) -> String {
        get{
           return self.substringWithRange( Range(start: self.startIndex.advancedBy(index),
                end: self.startIndex.advancedBy(index+1)))
        }
        set{
            self.replaceRange(
                Range(start: self.startIndex.advancedBy(index),
                    end: self.startIndex.advancedBy(index+1)
                ),
            with: newValue
            )
        }
        
    }
    
    public subscript(r:Range<Int>) -> String {
        get{
            return self.substringWithRange(
                Range(start: self.startIndex.advancedBy(r.startIndex),
                      end:   self.startIndex.advancedBy(r.endIndex)))
        }
        set{
            self.replaceRange(
                Range(start: self.startIndex.advancedBy(r.startIndex),
                      end:   self.startIndex.advancedBy(r.endIndex)
                ),
                with: newValue
            )
        }
    }
}
