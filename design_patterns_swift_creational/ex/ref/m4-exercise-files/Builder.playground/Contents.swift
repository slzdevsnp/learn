//: Builder
//: > The builder pattern can be used to control the creation of objects when direct instantiation would cause calling components to know the default configuration values for an object and when configuration data is obtained gradually.
//: > The intent of the Builder design pattern is to separate the construction of a complex object from its representation. By doing so the same construction process can create different representations.

import UIKit

/*:
 ### Create instances without the Builder
 */

let defaultTheme = Theme(backgroundColor: UIColor.white, textColor: UIColor.black, font: UIFont.systemFont(ofSize: 15))
let label = UILabel(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 800, height: 44)))
label.backgroundColor = defaultTheme.backgroundColor
label.textColor = defaultTheme.textColor
label.font = defaultTheme.font
label.text = "White background, black text, system font 15"

let alertTheme = Theme(backgroundColor: UIColor.white, textColor: UIColor.red, font: UIFont.systemFont(ofSize: 15))
let alertLabel = UILabel(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 800, height: 44)))
alertLabel.backgroundColor = alertTheme.backgroundColor
alertLabel.textColor = alertTheme.textColor
alertLabel.font = alertTheme.font
alertLabel.text = "White background, red text, system font 15"

/*:
 Instead of writing:
 
 let instance = ClassWithManyDefaults(prop1: value, prop2: value2, prop3: value3, ... propn: valuen)
 
 We could create convenience initializers so that callers must only provide values for the properties they wish to change:
 
 let instance = ClassWithManyDefaults(prop1: value, prop3: value3)
 
 Telescoping initializers are an anti-pattern. 
 We can replace telescoping initializers with a single init method which provides default argument values.
 */

let defaultTheme2 = Theme()
label.backgroundColor = defaultTheme2.backgroundColor
label.textColor = defaultTheme2.textColor
label.font = defaultTheme2.font
label.text = "White background, black text, system font 15"

let alertTheme2 = Theme(textColor: UIColor.red)
label.backgroundColor = alertTheme2.backgroundColor
label.textColor = alertTheme2.textColor
label.font = alertTheme2.font
label.text = "White background, red text, system font 15"

let customBackgroundTheme = Theme(backgroundColor: UIColor.yellow)
label.backgroundColor = customBackgroundTheme.backgroundColor
label.textColor = customBackgroundTheme.textColor
label.font = customBackgroundTheme.font
label.text = "Yellow background, black text, system font 15"

let invertedTheme = Theme(backgroundColor: UIColor.black, textColor: UIColor.white)
label.backgroundColor = invertedTheme.backgroundColor
label.textColor = invertedTheme.textColor
label.font = invertedTheme.font
label.text = "Black background, white text, system font 15"

//: Introducing ThemeBuilder
/*:
By introducing the Builder, we can separate the construction of objects from its representation:
let builder = Builder()
builder.prop1 = value1
builder.prop2 = value2
builder.prop3 = value3

let instance = builder.typeWithManyDefaults

builder.prop2 = anotherValue
let otheInstance = builder.typeWithManyDefaults
*/
//: ### Example of Builder Pattern from the iOS SDK
let dateBuilder = DateComponents(calendar: Calendar(identifier: .gregorian), timeZone: TimeZone(identifier: "PST"), year: 2020, month: 1, day: 1)
if let date = dateBuilder.date {
    print(date)
}

//: ### The ThemeBuilder in action
let themeBuilder = ThemeBuilder()

themeBuilder.backgroundColor = UIColor.blue
themeBuilder.textColor = UIColor.yellow
let blueTheme = themeBuilder.theme

label.backgroundColor = blueTheme.backgroundColor
label.textColor = blueTheme.textColor
label.text = "Blue background, yellow text, system font 15"

themeBuilder.backgroundColor = UIColor.red
themeBuilder.textColor = UIColor.white
let redTheme = themeBuilder.theme
label.backgroundColor = redTheme.backgroundColor
label.textColor = redTheme.textColor
label.font = redTheme.font
label.text = "Red background, white text, system font 15"
