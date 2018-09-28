//
//  User.swift
//  pchatapp
//
//  Created by Sviatoslav Zimine on 3/19/18.
//  Copyright © 2018 Sviatoslav Zimine. All rights reserved.
//

import UIKit

class User: NSObject {
    var username: String
    var email: String
    var uid: String
    var profileImageUrl: String
    
    init(uid: String, username: String, email: String, profileImageUrl: String){
            self.uid = uid
            self.username = username
            self.email   = email
            self.profileImageUrl = profileImageUrl
    }

}
