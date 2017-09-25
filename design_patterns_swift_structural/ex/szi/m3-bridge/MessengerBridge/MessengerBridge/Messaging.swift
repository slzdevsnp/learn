//
//  Messaging.swift
//  MessengerBridge
//
//  Created by Sviatoslav Zimine on 9/24/17.
//  Copyright © 2017 sviatoslav.zimin. All rights reserved.
//

import Foundation

protocol Messaging {
    func send(message: String, completionHandler: @escaping (Error?) -> Void)
}

//initially we have two messengers conforming to Messaging
class QuickMessenger: Messaging {
    public func send(message: String, completionHandler: @escaping (Error?) -> Void) {
        print("Message \"\(message)\" sent via e-mail")
        completionHandler(nil)
    }
}

class VIPMessenger: Messaging {
    public func send(message: String, completionHandler: @escaping (Error?) -> Void) {
        print("Message \"\(message)\"  sent via P2P")
        completionHandler(nil)
    }
}

// Later, we need to add the ability of sending encrypted messages for these 2 messengers

class SecureQuickMessenger: QuickMessenger {
    fileprivate func encrypt(message: String, key: UInt8) -> String {
        for codeUnit in message.utf8 {
            print("\(codeUnit) ", terminator: "")
        }
        print("Original: \(message) UTF8: \(message.utf8) encoded:\(String( describing: message.utf8.map{$0 ^ key} ))")
        
        return String( describing: message.utf8.map{$0 ^ key} )
    }
    
    public override func send(message: String, completionHandler: @escaping (Error?) -> Void) {
        let secure = self.encrypt(message: message, key: 0xcc)
        super.send(message: secure, completionHandler: completionHandler)
    }
}
class SecureVIPMessenger: VIPMessenger {
    fileprivate func encrypt(message: String, key: UInt8) -> String {
        return String( describing: message.utf8.map{$0 ^ key} )
    }
    
    public override func send(message: String, completionHandler: @escaping (Error?) -> Void) {
        let secure = self.encrypt(message: message, key: 0xcc)
        super.send(message: secure, completionHandler: completionHandler)
    }
}

// Next, we need to support the feature of self-destructing messages
// We add two more subclasses, SelfDestructingQuickMessenger and SelfDestructingVIPMessenger
class SelfDestructingQuickMessenger: QuickMessenger {
    public override func send(message: String, completionHandler: @escaping (Error?) -> Void) {
        let selfDestructingMessage = "☠" + message
        super.send(message: selfDestructingMessage, completionHandler: completionHandler)
    }
}

class SelfDestructingVIPMessenger: VIPMessenger {
    public override func send(message: String, completionHandler: @escaping (Error?) -> Void) {
        let selfDestructingMessage = "☠" + message
        super.send(message: selfDestructingMessage, completionHandler: completionHandler)
    }
}

// Yet next we need to add a new messanger supporting all existing features
// The number of classes keeps increasing as we implement a new requirement.
class EZMessenger: Messaging {
    public func send(message: String, completionHandler: @escaping (Error?) -> Void) {
        print("Self-destructing message \"\(message)\" sent")
        completionHandler(nil)
    }
}

class SecureEZMessenger: EZMessenger {
    fileprivate func encrypt(message: String, key: UInt8) -> String {
        return String( describing: message.utf8.map{$0 ^ key} )
    }
    
    public override func send(message: String, completionHandler: @escaping (Error?) -> Void) {
        let secure = self.encrypt(message: message, key: 0xcc)
        super.send(message: secure, completionHandler: completionHandler)
    }
}

class SelfDestructingEZMessenger: EZMessenger {
    public override func send(message: String, completionHandler: @escaping (Error?) -> Void) {
        let selfDestructingMessage = "☠" + message
        super.send(message: selfDestructingMessage, completionHandler: completionHandler)
    }
}




