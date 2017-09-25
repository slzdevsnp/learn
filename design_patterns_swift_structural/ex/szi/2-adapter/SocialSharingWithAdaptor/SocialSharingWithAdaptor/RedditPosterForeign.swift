//
//  RedditPosterForeign.swift
//  SocialSharingWithAdaptor
//
//  Created by Sviatoslav Zimine on 9/24/17.
//  Copyright © 2017 sviatoslav.zimin. All rights reserved.
//

import Foundation

//suppose we found  a third-party implementation for reddit
//it has another signature
// it does not adhere to a Sharing protocol
public class RedditPoster{
    public func post(text: String, completion: @escaping (Error?,UUID?)->Void){
        print("Message \(text) posted on Reddit")
        completion(nil,UUID())
    }
}

// lets add an adapter to make conform this class to Sharing protocol
public class RedditPosterAdapter: Sharing {
    private lazy var redditPoster = RedditPoster() // lazy init
    
    public func share(message: String, completionHandler: @escaping (Error?)->Void){
        redditPoster.post(text:message, completion: {(error,uid) in
            completionHandler(error)
        })
    }
}

//lets make RedditPoster conform to Sharing via an extension
extension RedditPoster: Sharing {
    public func share(message: String, completionHandler: @escaping (Error?)->Void ){
        self.post(text: message, completion: {(error, uuid) in
             completionHandler(error) } )
    }
}
