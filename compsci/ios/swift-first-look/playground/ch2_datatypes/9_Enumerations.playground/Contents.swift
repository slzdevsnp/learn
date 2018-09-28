//: Playground - noun: a place where people can play

import UIKit

enum SimpleCardType{
    case None
    case Visa
    case AmericanExpress
    case MasterCard
    case Discover
}

print("\(SimpleCardType.Visa)")

//enum with raw type and behavior methods

enum Cardtype: String {
    case None = "None"
    case Visa = "Visa"
    case Mastercard = "Mastercard"
    case AmericanExpress = "American Express"
    case Discover = "Discover"
    
    static let allValues = [Visa, AmericanExpress, Mastercard, Discover]
    
 //primitive card numbers regexp matching 
    private func regularExpression() -> NSRegularExpression {
        switch self {
        case .Visa:
            return NSRegularExpression(pattern: "^4[0-9]{12}(?:[0-9]{3})?$", options: nil, error: nil)
        case .AmericanExpress:
            return NSRegularExpression(pattern: "^3[47][0-9]{13}$", options: nil, error: nil)
        case .Mastercard:
            return NSRegularExpression(pattern: "^5[1-5][0-9]{14}$", options: nil, error: nil)
        case .Discover:
            return NSRegularExpression(pattern: "^6(?:011|5[0-9]{2})[0-9]{12}$", options: nil, error: nil)
        default:
            return NSRegularExpression(pattern: ".*", options: nil, error: nil)
        }
    }

    
    func isValidFor(cardNumber: String) -> Bool {
        let re = self.regularExpression()
        let range = NSRange(0..<cardNumber.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
        let matches = re.numberOfMatchesInString(cardNumber, options: nil, range:range)
        return matches > 0
    }
    
    static func from(cardNumber: String) -> CardType {
        for type in self.allValues {
            if type.isValidFor(cardNumber) {
                return type
            }
        }
        
        return None
    }

    
    
}

// MARK: - Testing

CardType.from("4242424242424242").toRaw()
CardType.from("4012888888881881").toRaw()
CardType.from("4000056655665556").toRaw()



