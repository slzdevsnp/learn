//
//  Sharing.swift
//  SocialSharingWithAdaptor
//
//  Created by Sviatoslav Zimine on 9/24/17.
//  Copyright © 2017 sviatoslav.zimin. All rights reserved.
//

import Foundation

protocol Sharing {
    //async method
    func share(message: String,
               completionHandler: @escaping (Error?)->Void )
}

//concrete classes
class FBSharer: Sharing {
    public func share(message: String, completionHandler: @escaping (Error?)->Void){
        print("Message \(message) shared on Facebook")
        completionHandler(nil)
    }
}

class TwitterSharer: Sharing {
    public func share(message: String, completionHandler: @escaping (Error?)->Void){
        print("Message \(message) shared on Twitter")
        completionHandler(nil)
    }
}
