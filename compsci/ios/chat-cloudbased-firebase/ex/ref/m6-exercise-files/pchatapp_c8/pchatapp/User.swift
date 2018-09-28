//
//  User.swift
//  pchatapp
//
//  Created by Brett Romero on 11/26/16.
//  Copyright © 2016 test. All rights reserved.
//

import UIKit

class User: NSObject {
    var username:String
    var email:String
    var uid:String
    var profileImageUrl:String
    
    init(uid:String, username:String, email:String, profileImageUrl:String){
        self.uid = uid
        self.username = username
        self.email = email
        self.profileImageUrl = profileImageUrl
    }

}
