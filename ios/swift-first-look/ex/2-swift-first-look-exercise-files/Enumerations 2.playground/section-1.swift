// Playground - noun: a place where people can play

import UIKit

// MARK: - Credit Cards (version 2)

class CreditCard: Printable {
    
    enum Type: String {
        case None = "None"
        case Visa = "Visa"
        case AmericanExpress = "American Express"
        case Mastercard = "Mastercard"
        case Discover = "Discover"
        
        static let allValues = [Visa, AmericanExpress, Mastercard, Discover, None]
        
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
        
        func isValidFor(number: String) -> Bool {
            let matches = self.regularExpression().numberOfMatchesInString(number, options: nil, range: NSRange(0..<number.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)))
            
            return matches > 0
        }
        
        static func from(value: String) -> Type {
            for type in self.allValues {
                if type.isValidFor(value) {
                    return type
                }
            }
            
            return None
        }
    }
    
    struct ExpirationDate {
        let month: UInt
        let year: UInt
    }
    
    let cardNumber: String
    let expirationDate: ExpirationDate
    let type: Type
    var description: String {
        return "\(self.cardNumber) expires: \(self.expirationDate.month)/\(self.expirationDate.year) (\(self.type.toRaw()))"
    }
    
    init(cardNumber: String, expiration: ExpirationDate) {
        self.cardNumber = cardNumber
        self.expirationDate = expiration
        self.type = Type.from(self.cardNumber)
    }
    
    convenience init(cardNumber: String, expMonth: UInt, expYear: UInt) {
        self.init(cardNumber: cardNumber, expiration: ExpirationDate(month: expMonth, year: expYear))
    }
}

// MARK: - Testing

//let visa1 = CreditCard(cardNumber: "4242424242424242", expiration: CreditCard.ExpirationDate(month: 8, year: 2016))
let vs = CreditCard(cardNumber: "4242424242424242", expMonth: 8, expYear: 2016)
let mc = CreditCard(cardNumber: "5555555555554444", expiration: CreditCard.ExpirationDate(month: 6, year: 2012))
let ax = CreditCard(cardNumber: "378282246310005", expiration: CreditCard.ExpirationDate(month: 2, year: 2018))
let disc = CreditCard(cardNumber: "6011111111111117", expiration: CreditCard.ExpirationDate(month: 3, year: 2014))
let uk = CreditCard(cardNumber: "3566002020360505", expiration: CreditCard.ExpirationDate(month: 2, year: 2012))


