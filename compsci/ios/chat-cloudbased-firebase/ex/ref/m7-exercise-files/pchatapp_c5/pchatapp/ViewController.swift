//
//  ViewController.swift
//  pchatapp
//
//  Created by Brett Romero on 11/1/16.
//  Copyright © 2016 test. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var username: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func loginButton_click(_ sender: AnyObject) {
        //let email = "test1@gmail.com"
        //let password = "openopen"
        FirebaseManager.Login(email: email.text!, password: password.text!) { (success:Bool) in
            if(success){
                self.performSegue(withIdentifier: "showProfile", sender: sender) 
            }
        }
    }
    
    @IBAction func createAccountButton_click(_ sender: AnyObject) {
        FirebaseManager.CreateAccount(email: email.text!, password: password.text!, username: username.text!){
            (result:String) in
            DispatchQueue.main.async{
                self.performSegue(withIdentifier: "showProfile", sender: sender)
            }
        }
    }
    

}

