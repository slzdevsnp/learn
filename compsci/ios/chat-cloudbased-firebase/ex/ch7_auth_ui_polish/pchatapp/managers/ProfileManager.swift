//
//  ProfileManager.swift
//  pchatapp
//
//  Created by Sviatoslav Zimine on 3/19/18.
//  Copyright © 2018 Sviatoslav Zimine. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class ProfileManager: NSObject {
    static let usersRoot = "users"
    
    static let databaseRef = Database.database().reference()
    static let uid = Auth.auth().currentUser?.uid
    static var users = [User]()
    
    static func getCurrentUser(uid:String) -> User? {
        if let i = users.index(where: {$0.uid == uid}){
            return users[i]
        }
        return nil
    }
    
    static func fillUsers(completion: @escaping () -> Void) {
        users = []
        databaseRef.child(usersRoot).observe(.childAdded, with: {
            snapshot in
            print(snapshot) //4 debugging
            if let result = snapshot.value as? [String:AnyObject]{
                let uid = result["uid"]! as! String
                let username = result["username"]! as! String
                let email = result["email"]! as! String
                let profileImageUrl = result["profileImageUrl"]! as! String
                
                let u = User(uid: uid, username: username, email: email, profileImageUrl: profileImageUrl)
                ProfileManager.users.append(u)
            }
            completion()
        })
    }
}
