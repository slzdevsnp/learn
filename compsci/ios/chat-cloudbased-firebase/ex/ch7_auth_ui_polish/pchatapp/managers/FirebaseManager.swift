//
//  FirebaseManager.swift
//  pchatapp
//
//  Created by Sviatoslav Zimine on 3/19/18.
//  Copyright © 2018 Sviatoslav Zimine. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class FirebaseManager: NSObject {
    static let databaseRef = Database.database().reference()
    static var currentUserId: String = ""
    static var currentUser: Firebase.User? = nil
    
    
    static func Login(email: String, password: String,
                      completion: @escaping (_ success: Bool)->Void){
        Auth.auth().signIn(withEmail: email, password: password,
                           completion: { (user, error) in
                                if let error = error {
                                    print(error.localizedDescription)
                                    completion(false)
                                }else {
                                    currentUser = user
                                    currentUserId = (user?.uid)!
                                    completion(true)
                                }
                            })

    }

 
    static func createAccount(email: String, password: String, username: String, completion: @escaping (_ result:String) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user,error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            //user added ok, lets log him in
            AddUser(username: username, email: email)
            Login(email: email, password: password){
                (success: Bool) in
                if success {
                    print ("login OK afeter account createion")
                }else{
                    print("login NOK after acount creation")
                }
            }
            completion("")
        })
    }
    
    static func AddUser(username: String, email: String){
        let uid = Auth.auth().currentUser?.uid
        let post = ["uid": uid!,
                    "username":username,
                    "email": email,
                    "profileImageUrl": "" ]
        databaseRef.child("users").child(uid!).setValue(post)
    }
    
}
