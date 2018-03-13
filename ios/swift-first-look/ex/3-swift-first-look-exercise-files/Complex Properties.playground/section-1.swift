// Playground - noun: a place where people can play

import UIKit

class Calendar {
    // For a property that requires some non-trivial setup, you can create
    // and execute a closure. This is equivalent to setting this up in a
    // initializer. The advantage here is putting the property initialization
    // code right next to the declaration
    var frenchMonths: [String] = {
        println("Calculating French months...") // should only see once
        let df = NSDateFormatter()
        df.locale = NSLocale(localeIdentifier: "fr_FR")
        return df.monthSymbols.map() { $0 as String }
    }()
    
    var japaneseMonths: [String]
    
    init() {
        // Non-trivial properties can be setup in the initializer too
        println("Calculating Japanese months...") // should only see once
        let df = NSDateFormatter()
        df.locale = NSLocale(localeIdentifier: "ja_JP")
        self.japaneseMonths = df.monthSymbols.map() { $0 as String }
    }
}

let cal = Calendar()
cal.frenchMonths
cal.frenchMonths

cal.japaneseMonths
cal.japaneseMonths