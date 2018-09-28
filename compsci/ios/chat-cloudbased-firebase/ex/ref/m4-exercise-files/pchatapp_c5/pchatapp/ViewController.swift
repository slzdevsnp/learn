//
//  ViewController.swift
//  pchatapp
//
//  Created by Brett Romero on 11/1/16.
//  Copyright © 2016 test. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func loginButton_click(_ sender: AnyObject) {
        let email = "test2@gmail.com"
        let password = "openopen"
        FirebaseManager.Login(email: email, password: password) { (success:Bool) in
            if(success){
                self.performSegue(withIdentifier: "showProfile", sender: sender) 
            }
        }
    }
    

}

