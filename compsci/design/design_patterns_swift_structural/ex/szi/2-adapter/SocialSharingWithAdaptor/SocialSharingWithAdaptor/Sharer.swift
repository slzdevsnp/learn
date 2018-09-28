//
//  Sharer.swift
//  SocialSharingWithAdaptor
//
//  Created by Sviatoslav Zimine on 9/24/17.
//  Copyright © 2017 sviatoslav.zimin. All rights reserved.
//

import Foundation

//sharerer utility
public enum SharerType: String, CustomStringConvertible {
    case facebook  = "Facebook"
    case twitter = "Twitter"
    case reddit = "Reddit"
    
    public var description: String {
        return "\(self.rawValue) sharer"
    }
}

public class Sharer {
    private let shareServices: [SharerType: Sharing] =
        [ .facebook: FBSharer(),
          .twitter: TwitterSharer()]
    
    private lazy var redditPoster = RedditPoster() // delayed initialization
    
    public func shareEverywhere(message : String) {
        for (serviceType, sharer) in shareServices {
            sharer.share(message: message, completionHandler:{(error) in
                if error != nil {
                    print("Error while sharing \(message) via \(serviceType)")
                }
            })
        }
        //also share on reddit
        redditPoster.post(text: message) { (error, uuid) in
            if error != nil {
                print("error occured while sharing \(message) via \(SharerType.reddit)")
            }
        }
    }
    
    public func share(message: String, serviceType: SharerType,
                      completionHandler: @escaping (Error?)->Void ){
        //special case for reddit with foreign interface
        if serviceType == .reddit{
            redditPoster.post(text: message, completion: {(error, uid) in
                completionHandler(error)
            })
        }  //!!! we start to add messy conditional logic to the Sharer class
            //case for classes sharing the same protocol
        else if let service = shareServices[serviceType] {
            service.share(message: message, completionHandler: completionHandler)
        }
    }
}

// redefine the Sharer cleaner class which uses the adapter of a foreign sharer
public class SharerLeveragingAdapter {
    private let shareServices: [SharerType: Sharing] =
        [ .facebook: FBSharer(),
          .twitter: TwitterSharer(),
          .reddit: RedditPosterAdapter()]  //now we can add reddit in the dictionary !
    
    public func shareEverywhere(message : String) {
        for (serviceType, sharer) in shareServices {
            sharer.share(message: message, completionHandler:{(error) in
                if error != nil {
                    print("Error while sharing \(message) via \(serviceType)")
                }
            })
        }
    }
    public func share(message: String, serviceType: SharerType,
                      completionHandler: @escaping (Error?)->Void ){
        if let service = shareServices[serviceType] {
            service.share(message: message, completionHandler: completionHandler)
        }
    }
}

// redefined the Sharer class with RedditPoster confirming to Sharing
public class SharerCleanAdapter {
    private let shareServices: [SharerType: Sharing] =
        [ .facebook: FBSharer(),
          .twitter: TwitterSharer(),
          .reddit: RedditPoster()]  //now reddit poster conforms to Sharing via extension
    
    public func shareEverywhere(message : String) {
        for (serviceType, sharer) in shareServices {
            sharer.share(message: message, completionHandler:{(error) in
                if error != nil {
                    print("Error while sharing \(message) via \(serviceType)")
                }
            })
        }
    }
    public func share(message: String, serviceType: SharerType,
                      completionHandler: @escaping (Error?)->Void ){
        if let service = shareServices[serviceType] {
            service.share(message: message, completionHandler: completionHandler)
        }
    }
}


