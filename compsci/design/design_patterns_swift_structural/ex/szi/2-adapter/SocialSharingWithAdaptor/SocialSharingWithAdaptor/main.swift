//
//  main.swift
//  SocialSharingWithAdaptor
//
//  Created by Sviatoslav Zimine on 9/24/17.
//  Copyright © 2017 sviatoslav.zimin. All rights reserved.
//

import Foundation

private func printHeader(_ label: String){
    print("\n*******************************************")
    print("*\t\(label)")
    print("*******************************************\n")

}


//##################################
//#
//#  main
//#
//##################################

let sharer = Sharer()
printHeader("standard sharer")
sharer.share(message: "FBish hello", serviceType: .facebook) { (error) in
    if error != nil {
        print("Could not share")
    }
}

printHeader("lets call a non-standard sharer")
sharer.share(message: "Redditish hello", serviceType: .reddit ) { (error) in
    if error != nil {
        print("Could not share")
    }
}

printHeader("lets call all sharers")
sharer.shareEverywhere(message: "Shout from all roofs")

printHeader("define a sharer using an adapter and call shareEverywhere")
let asharer = SharerLeveragingAdapter()
asharer.shareEverywhere(message: "Shout everywhere homogeniously")

printHeader("define sharer using RedditPoster conforming to protocol via extension")
let csharer = SharerCleanAdapter()
csharer.shareEverywhere(message: "Shout everywhere clean and nicely")


