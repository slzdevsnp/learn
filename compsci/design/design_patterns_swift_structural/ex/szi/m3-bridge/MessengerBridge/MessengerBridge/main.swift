//
//  main.swift
//  MessengerBridge
//
//  Created by Sviatoslav Zimine on 9/24/17.
//  Copyright © 2017 sviatoslav.zimin. All rights reserved.
//

import Foundation

private func printHeader(_ label: String){
    print("\n***********************************************")
    print("\(label)")
    print("***********************************************\n")
}

printHeader("Send msg using QuickMessenger and VipMessenger in plain and encrypted")

var message = "Hello"
let quickMessenger = QuickMessenger()
quickMessenger.send(message: message) { (error) in
    guard error == nil else {
        print("Could not send message")
        return
    }
}
let secureQuickMessenger = SecureQuickMessenger()
secureQuickMessenger.send(message: message) { (error) in
    guard error == nil else {
        print("Could not send message")
        return
    }
}


let vipMessenger = VIPMessenger()
vipMessenger.send(message: message) { (error) in
    guard error == nil else {
        print("Could not send message")
        return
    }
}

let secureVIPMessenger = SecureVIPMessenger()
secureVIPMessenger.send(message: message) { (error) in
    guard error == nil else {
        print("Could not send message")
        return
    }
}

printHeader("Send msg using mew EZMessenger")

let ezMessenger = EZMessenger()
ezMessenger.send(message: message) { (error) in
    guard error == nil else {
        print("Could not send message")
        return
    }
}
let secureEZMessenger = SecureEZMessenger()
secureEZMessenger.send(message: message) { (error) in
    guard error == nil else {
        print("Could not send message")
        return
    }
}


printHeader("send message using a quick message sender refactored")
message = "Hello Bridged"
let quickMessageHandler = BQuickMessageSender()
quickMessageHandler.send(messageHandler: PlainMessageHandler(), message: message) { (error) in
        guard error == nil  else {
           print("could not send the message")
           return
        }
}
let vipMessageHandler = BVIPMessageSender()
vipMessageHandler.send(messageHandler: PlainMessageHandler(), message: message) { (error) in
    guard error == nil else {
        print("Could not send message")
        return
    }
}
// Send encrypted messages
quickMessageHandler.send(messageHandler: SecureMessageHandler(), message: message) { (error) in
    guard error == nil else {
        print("Could not send message")
        return
    }
}

vipMessageHandler.send(messageHandler: SecureMessageHandler(), message: message) { (error) in
    guard error == nil else {
        print("Could not send message")
        return
    }
}
// Send self-destructing messages
quickMessageHandler.send(messageHandler: SelfDestructingMessageHandler(), message: message) { (error) in
    guard error == nil else {
        print("Could not send message")
        return
    }
}

vipMessageHandler.send(messageHandler: SelfDestructingMessageHandler(), message: message) { (error) in
    guard error == nil else {
        print("Could not send message")
        return
    }
}

