//
//  PostManager.swift
//  pchatapp
//
//  Created by Sviatoslav Zimine on 3/19/18.
//  Copyright © 2018 Sviatoslav Zimine. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth


class PostManager: NSObject {
    
    static let postsRoot = "posts"
    
    static let databaseRef =  Database.database().reference()
    static var posts = [Post]()
    
    static func fillPosts(uid:String?, toId:String, completion: @escaping(_ result:String) -> Void) {
        posts = []
        let allPost = databaseRef.child(postsRoot)
        print(allPost)
        let post = databaseRef.child(postsRoot).queryOrdered(byChild: "uid").queryEqual(toValue: FirebaseManager.currentUser?.uid).observe(.childAdded, with: {
            snapshot in
            print(snapshot)
        })
        
        databaseRef.child(postsRoot).queryOrdered(byChild: "uid").queryEqual(toValue: FirebaseManager.currentUser?.uid).observe(.childAdded, with:{
            snapshot in
            print(snapshot)
            if let result = snapshot.value as? [String:AnyObject]{
                let toIdCloud = result["toId"]! as! String
                if(toIdCloud == toId){
                    let p = Post(username: result["username"]! as! String, text: result["text"]! as! String, toId: result["toId"]! as! String)
                    PostManager.posts.append(p)
                }
            }
            completion("")
        })
    }
}



class Post {
    var username: String = ""
    var text: String = ""
    var toId: String = ""
    
    init(username:String, text:String, toId:String){
        self.username = username
        self.text  = text
        self.toId = toId
    }
    
}
