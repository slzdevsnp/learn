//: SocialSharing Demo

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

//suppose we found  a third-party implementation for reddit
//it has another signature
public class RedditPoster{
    public func post(text: String, completion: @escaping (Error?,UUID?)->Void){
        print("Message \(text) posted on reddit")
        completion(nil,UUID())
    }
}

//##################################
//#
//#  main
//#
//##################################
let sharer = Sharer()
sharer.share(message: "FBish hello", serviceType: .facebook) { (error) in
    if error != nil {
        print("Could not share")
    }
}
print("*** now lets call all sharers")
sharer.shareEverywhere(message: "Shout from all roofs")

sharer.share(message: "Redditish hello", serviceType: .reddit ) { (error) in
    if error != nil {
        print("Could not share")
    }
}

