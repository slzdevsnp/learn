// Playground - noun: a place where people can play

import UIKit

// MARK: - Credit Cards

enum CardType: String {
    case None = "None"
    case Visa = "Visa"
    case AmericanExpress = "American Express"
    case Mastercard = "Mastercard"
    case Discover = "Discover"
    
    static let allValues = [Visa, AmericanExpress, Mastercard, Discover]

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

CardType.from("5555555555554444").toRaw()
CardType.from("5200828282828210").toRaw()
CardType.from("5105105105105100").toRaw()

CardType.from("378282246310005").toRaw()
CardType.from("371449635398431").toRaw()

CardType.from("6011111111111117").toRaw()
CardType.from("6011000990139424").toRaw()

CardType.from("3566002020360505").toRaw()

