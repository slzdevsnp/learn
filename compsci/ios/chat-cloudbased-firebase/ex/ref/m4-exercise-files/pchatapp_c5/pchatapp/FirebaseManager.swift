//
//  FirebaseManager.swift
//  pchatapp
//
//  Created by Brett Romero on 11/12/16.
//  Copyright © 2016 test. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class FirebaseManager: NSObject {
    static let databaseRef = FIRDatabase.database().reference()
    static var currentUserId:String = ""
    static var currentUser:FIRUser? = nil
    
    static func Login(email:String, password:String, completion: @escaping (_ success:Bool) -> Void) {
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(false)
            } else {
                currentUser = user
                currentUserId = (user?.uid)!
                completion(true) }
        })
    }
}
