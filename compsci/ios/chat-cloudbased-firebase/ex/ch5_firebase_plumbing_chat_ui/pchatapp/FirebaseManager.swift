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
    static var currentUser: User? = nil
    
    
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

    
}
