//
//  MessagingBridge.swift
//  MessengerBridge
//
//  Created by Sviatoslav Zimine on 9/24/17.
//  Copyright © 2017 sviatoslav.zimin. All rights reserved.
//

import Foundation

//we have 1 protocol for messaging sending and  1 protocol for message prepration

protocol MessageSending {
    func send(messageHandler: MessageHandler, message: String, completionHandler: @escaping (Error?) -> Void)
}

public protocol MessageHandler {
    func modify(message: String) -> String
}

// Instead of introducing a new subclass for each new feature, we only have to add a new MessageHandler implementation class

public class PlainMessageHandler: MessageHandler {
    public func modify(message: String) -> String {
        // returns unmodified message
        return message
    }
}

public class SecureMessageHandler: MessageHandler {
    fileprivate func encrypt(message: String, key: UInt8) -> String {
        return String( describing: message.utf8.map{$0 ^ key} )
    }
    //returns an encrypted message
    public func modify(message: String) -> String {
        return self.encrypt(message: message, key: 0xcc)
    }
}

public class SelfDestructingMessageHandler: MessageHandler {
    public func modify(message: String) -> String {
        return "☠" + message
    }
}

// We only have to add new message handlers whenever there is a new requirement for modifying the message before it is sent. The Message sender classes remain unaffected.

class BQuickMessageSender: MessageSending {
    public func send(messageHandler:MessageHandler, message: String, completionHandler: @escaping (Error?) -> Void) {
        let modifiedMessage = messageHandler.modify(message: message)
        print("Message \"\(modifiedMessage)\" sent via e-mail")
        completionHandler(nil) //execution without error
    }
}

class BVIPMessageSender: MessageSending {
    public func send(messageHandler:MessageHandler, message: String, completionHandler: @escaping (Error?) -> Void) {
        let modifiedMessage = messageHandler.modify(message: message)
        print("Message \"\(modifiedMessage)\"  sent via P2P")
        completionHandler(nil)
    }
}

class BEZMessageSender: MessageSending {
    public func send(messageHandler:MessageHandler, message: String, completionHandler: @escaping (Error?) -> Void) {
        let modifiedMessage = messageHandler.modify(message: message)
        print("Message \"\(modifiedMessage)\"  sent via P2P")
        completionHandler(nil)
    }
}


